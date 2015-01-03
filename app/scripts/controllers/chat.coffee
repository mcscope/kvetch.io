angular.module("kvetchApp").controller "ChatCtrl", ($scope, $routeParams, $firebase, $timeout, $upload, FocusManager, Notification, Author) ->
  alert = (msg) ->
    $scope.err = msg

    $timeout ->
      $scope.err = null
    , 5000

  $scope.rootId = $routeParams.rootId or '-JeET71Lq_8X116CKmTs'
  messagesRef = new Firebase('https://kvetch.firebaseio.com/messages/')

  $scope.newMessage = {}

  $scope.addMessage = (text) ->
    return unless $scope.newMessage.text

    addMessage($scope.newMessage)

    $scope.newMessage = {}

  addMessage = (newMessage) ->
    parent = FocusManager.focused
    parentId = parent.attr('rootId')

    newMessage.createdAt = +new Date
    newMessage.author = Author.get()
    newMessage.parents = [parentId]

    # Force the new element to take focus
    FocusManager.set null

    $firebase(messagesRef).$push(newMessage)
      .then (ref) ->
        newMessage.$id = ref.key()

        parentMessage = $firebase(messagesRef.child(parentId)).$asObject()
        parentMessage.$loaded().then ->
          parentMessage.children ?= []
          parentMessage.children.push newMessage.$id
          parentMessage.$save()

      , alert

  $scope.uploading = false

  $scope.fileDropped = (files) ->
    progress = {}

    $scope.uploading = true
    $scope.uploadProgress = 0
    updateProgress = ->
      return unless $scope.uploading

      done = true

      $scope.uploadProgress = 0
      for i of files
        progress[i] ?= 0
        done &= progress[i] is 100

        $scope.uploadProgress += progress[i] / files.length

      if done
        addMessage {text}
        $scope.uploading = false

    text = ''
    for file, i in files
      do (file, i) ->
        filename = (+new Date) + '-' + file.name
        progress[i] = 0

        $upload.upload
          url: 'https://kvetch-uploads.s3.amazonaws.com/'
          method: 'POST'
          data:
            key: filename
            AWSAccessKeyId: 'AKIAIDKKQTZT6S5MYBNQ'
            'Content-Type': file.type
            acl: 'public-read'
            policy: 'ewogICJleHBpcmF0aW9uIjogIjIwMjAtMDEtMDFUMDA6MDA6MDBaIiwKICAiY29uZGl0aW9ucyI6IFsKICAgIHsiYnVja2V0IjogImt2ZXRjaC11cGxvYWRzIn0sCiAgICBbInN0YXJ0cy13aXRoIiwgIiRrZXkiLCAiIl0sCiAgICB7ImFjbCI6ICJwdWJsaWMtcmVhZCJ9LAogICAgWyJzdGFydHMtd2l0aCIsICIkQ29udGVudC1UeXBlIiwgIiJdLAogICAgWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDAsIDUwMDAwMDBdCiAgXQp9'
            signature: 'kRB3TF1veYpoN5rGoIIvmpCYM5w='
          file: file

        .progress (evt) ->
          progress[i] = 100 * (evt.loaded / evt.total)
          updateProgress()

        .success ->
          progress[i] = 100
          updateProgress()

        text += "http://kvetch-uploads.s3-website-us-east-1.amazonaws.com/#{ filename } "

  $scope.submitIfEnter = (event) ->
    if event.keyCode is 13 and not event.shiftKey
      event.preventDefault()
      $scope.addMessage()

  Notification.init
    rootId: $scope.rootId
