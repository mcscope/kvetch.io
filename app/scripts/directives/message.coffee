imageRe =
youtubeRe = /https?:\/\/www.youtube.com\/watch?[^ ]*( |$)/ig

regex =
  images:
    re: /https?:\/\/.*\.(?:jpg|jpeg|gif|png|webp|svg)/ig
    replacement: (images) -> "<a href='#{ images[0] }' target='_blank'>image</a>"
  youtubeVideos:
    re: /https?:\/\/www.youtube.com\/watch?[^ ]*( |$)/ig
    replacement: (videos) -> "<a href='#{ videos[0] }' target='_blank'>video</a>"

angular.module('kvetchApp')
  .directive 'message', (Notification) ->
    templateUrl: 'views/message.html'
    restrict: 'E'
    scope:
      message: '='
    link: (scope, element, attrs) ->
      scope.humanize = (datetime = "") ->
        moment(datetime).fromNow()

      scope.formatDateString = (datetime = "") ->
        moment(datetime).toISOString()

      do updateMessage = ->
        return unless scope.message?

        scope.text = scope.message.text
        for type, pat of regex
          scope[type] = []

          pat.re.lastIndex = 0
          while item = pat.re.exec(scope.text)
            scope[type].push item[0]

          if scope[type].length is 1
            scope.text = scope.text.replace scope[type][0], pat.replacement(scope[type])

      scope.$watch 'message.text', updateMessage

      scope.$on 'notification-click', (e, {message}) ->
        if message?.$id is scope.message?.$id
          element[0].scrollIntoViewIfNeeded()

      scope.$watch 'message.$id', ->
        if scope.message and Notification.lastNotice?.message?.$id is scope.message.$id
          element[0].scrollIntoViewIfNeeded()
          Notification.lastNotice = null
