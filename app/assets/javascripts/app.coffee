receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

receta.config([ '$routeProvider', 'flashProvider', '$locationProvider'
  ($routeProvider,flashProvider, $locationProvider)->

    $locationProvider.html5Mode(true)

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
    .when('/',
      templateUrl: "index.html"
      controller: 'RecipesController'
    ).when('/recipes/new',
      templateUrl: "form.html"
      controller: 'RecipeController'
    ).when('/recipes/:recipeId',
      templateUrl: "show.html"
      controller: 'RecipeController'
    ).when('/recipes/:recipeId/edit',
      templateUrl: "form.html"
      controller: 'RecipeController'
    ).otherwise({redirectTo:"/"})
])

receta.config(($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
)


controllers = angular.module('controllers',[])
controllers.controller("RecipesController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->

    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' })

    if $routeParams.keywords
      Recipe.query(keywords: $routeParams.keywords, (results)-> $scope.recipes = results)
    else
      $scope.recipes = []
])