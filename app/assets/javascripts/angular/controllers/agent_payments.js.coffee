#class @AgentPaymentsController
window.app.controller 'agentPayments', ($scope, $http, paymentsModel)->
  #$scope.searchArg = "Fight"
  $scope.head = window.head

  paymentsModel.getPayments($scope)

  $scope.sort =
    column: 'created_at'
    descending: true
  $scope.nameFilter = ''
  
  $scope.processPayment = (index, value)->
    paymentsModel.processPayment($scope, index, value)

  $scope.selectedCls = (column)->
    paymentsModel.selectedCls($scope, column)
    
  $scope.changeSorting = (column)->
    paymentsModel.changeSorting($scope, column)