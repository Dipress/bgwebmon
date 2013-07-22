window.app.service 'monitoringModel', ['$http', ($http)->

  this.getContacts = ($scope)->
    $http( method: "GET", url: '/new_mon.json').success (data)->
      console.log data
      $scope.contracts = data
]