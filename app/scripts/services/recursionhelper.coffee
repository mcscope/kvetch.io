###*
 # @ngdoc service
 # @name kvetchApp.Recursionhelper
 # @description
 # # Recursionhelper
 # Service in the kvetchApp.
###
angular.module('kvetchApp')
  .factory 'RecursionHelper', ($compile) ->
    return compile: (element, link) ->

      # Normalize the link parameter
      link = post: link if angular.isFunction(link)

      # Break the recursion loop by removing the contents
      contents = element.contents().remove()
      compiledContents = undefined

      {
        pre: link?.pre

        ###*
        Compiles and re-adds the contents
        ###
        post: (scope, element) ->
          compiledContents ?= $compile(contents)

          compiledContents scope, (clone) ->
            element.append clone

          link?.post?(arguments...)
      }
