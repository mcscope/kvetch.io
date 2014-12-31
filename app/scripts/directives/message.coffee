imageRe = /https?:\/\/.*\.(?:jpg|jpeg|gif|png|webp|svg)/ig

angular.module('kvetchApp')
  .directive('message', ->
    templateUrl: 'views/message.html'
    restrict: 'E'
    scope:
      message: '='
    link: (scope, element, attrs) ->
      do updateMessage = ->
        scope.images = []

        imageRe.lastIndex = 0
        while image = imageRe.exec(scope.message.text)
          scope.images.push image[0]

        scope.text = scope.message.text
        if scope.images.length is 1
          scope.text = scope.text.replace scope.images[0], "<a href='#{ scope.images[0] }' target='_blank'>image</a>"

      scope.$watch 'message.text', updateMessage
  )
