angular.module('kvetchApp')
  .service 'Author', ($firebaseAuth) ->

    ref = new Firebase('https://kvetch.firebaseio.com/messages/')
    auth = $firebaseAuth(ref)

    getAuthor = () ->
      authData = auth.$getAuth()

      if not authData
        return null

      if authData.provider == 'github'
        return {
          name: authData.github.cachedUserProfile.login
          avatar: authData.github.cachedUserProfile.avatar_url
          uid: authData.uid
        }

      if authData.provider == 'twitter'
        return {
          name: '@' + authData.twitter.username
          avatar: authData.twitter.cachedUserProfile.profile_image_url
          uid: authData.uid
        }

    return {
      get: getAuthor
    }
