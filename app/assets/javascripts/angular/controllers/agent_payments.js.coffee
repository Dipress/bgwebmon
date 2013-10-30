#class @AgentPaymentsController
window.app.controller 'agentPayments', ['$scope', '$http', 'paymentsModel', ($scope, $http, paymentsModel)->
  #$scope.searchArg = "Fight"
  $scope.head = window.head

  paymentsModel.getPayments($scope, $scope.pagination.page)

  $scope.sort =
    column: 'id'
    descending: true
  $scope.nameFilter = ''
  
  ###
  $scope.processPayment = (event, index, value)->
    event.preventDefault()
    paymentsModel.processPayment($scope, index, value)
  ###

  $scope.paginatePayments = (event, page)->
    event.preventDefault()
    paymentsModel.getPayments($scope, page)

  $scope.confirmationPayment = (event, index, value)->
    event.preventDefault()
    paymentsModel.confirmationPayment($scope, index, value)

  $scope.processingPayment = (event, index, value)->
    event.preventDefault()
    paymentsModel.processingPayment($scope, index, value)

  $scope.selectedCls = (column)->
    paymentsModel.selectedCls($scope, column)
    
  $scope.changeSorting = (column)->
    paymentsModel.changeSorting($scope, column)
]