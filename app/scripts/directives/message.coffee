imageRe = /https?:\/\/.*\.(?:jpg|jpeg|gif|png|webp|svg)/ig

angular.module('kvetchApp')
  .directive 'message', (Notification) ->
    templateUrl: 'views/message.html'
    restrict: 'E'
    scope:
      message: '='
    link: (scope, element, attrs) ->
      scope.humanize = (datetime) ->
        moment(datetime).fromNow()

      do updateMessage = ->
        return unless scope.message?

        scope.images = []

        imageRe.lastIndex = 0
        while image = imageRe.exec(scope.message.text)
          scope.images.push image[0]

        scope.text = scope.message.text
        if scope.images.length is 1
          scope.text = scope.text.replace scope.images[0], "<a href='#{ scope.images[0] }' target='_blank'>image</a>"

      scope.$watch 'message.text', updateMessage

      scope.$on 'notification-click', (e, {message}) ->
        if message?.$id is scope.message?.$id
          element[0].scrollIntoViewIfNeeded()

      scope.$watch 'message.$id', ->
        if scope.message and Notification.lastNotice?.message?.$id is scope.message.$id
          element[0].scrollIntoViewIfNeeded()
          Notification.lastNotice = null
