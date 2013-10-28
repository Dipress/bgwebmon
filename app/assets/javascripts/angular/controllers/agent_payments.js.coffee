#class @AgentPaymentsController
window.app.controller 'agentPayments', ['$scope', '$http', 'paymentsModel', ($scope, $http, paymentsModel)->
  #$scope.searchArg = "Fight"
  $scope.head = window.head

  paymentsModel.getPayments($scope)

  $scope.sort =
    column: 'id'
    descending: true
  $scope.nameFilter = ''
  
  $scope.processPayment = (event, index, value)->
    event.preventDefault()
    paymentsModel.processPayment($scope, index, value)

  $scope.confirmationPayment = (event, index, value)->
    event.preventDefault()
    paymentsModel.confirmationPayment($scope, index, value)

  $scope.selectedCls = (column)->
    paymentsModel.selectedCls($scope, column)
    
  $scope.changeSorting = (column)->
    paymentsModel.changeSorting($scope, column)
]