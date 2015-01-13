imageRe =
youtubeRe = /https?:\/\/www.youtube.com\/watch?[^ ]*( |$)/ig

regex =
  images:
    re: /https?:\/\/.*\.(?:jpg|jpeg|gif|png|webp|svg)/ig
    replacement: (image) -> "<a href='#{ image[0] }' target='_blank'>image</a>"
  youtubeVideos:
    re: /https?:\/\/www.youtube.com\/watch?[^ ]*( |$)/ig
    replacement: (video) -> "<a href='#{ video[0] }' target='_blank'>video</a>"
  links:
    re: /^([^<]*)(?: |^)((https?:\/\/)?(www\.)?[^ ]+\.[^ ]{2,}(\/[^ ]*)?)($| )/ig
    replacement: (link) -> "#{ link[1] } <a href='#{ link[2] }' target='_blank'>#{ link[2] }</a>"

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
          items = []

          pat.re.lastIndex = 0
          while item = pat.re.exec(scope.text)
            items.push item
            scope[type].push item[0]

          for item in items
            scope.text = scope.text.replace item[0], pat.replacement(item)

      scope.$watch 'message.text', updateMessage

      scope.$on 'notification-click', (e, {message}) ->
        if message?.$id is scope.message?.$id
          element[0].scrollIntoViewIfNeeded()

      scope.$watch 'message.$id', ->
        if scope.message and Notification.lastNotice?.message?.$id is scope.message.$id
          element[0].scrollIntoViewIfNeeded()
          Notification.lastNotice = null
