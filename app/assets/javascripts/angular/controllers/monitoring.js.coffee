window.app.controller 'monitoringCtrl', ['$scope', '$http', 'monitoringModel', ($scope, $http, monitoringModel)->
  monitoringModel.getContacts $scope
]