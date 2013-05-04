window.app.service 'paymentsModel', ['$http', ($http)->

  this.getPayments = ($scope)->
    $http( method: "GET", url: '/agent_payments.json').success (data)->
      $scope.body = data

  this.processPayment = ($scope, index, value)->
    $http( method: "PUT", url: "/agent_payments/#{value}/?format=json").success (data)->
      $.each $scope.body, (i, v)->
        if v.id == value
          $scope.body[i] = data

  this.selectedCls = ($scope, column)->
    column == $scope.sort.column && 'sort-' + $scope.sort.descending;


  this.changeSorting = ($scope, column)->
    sort = $scope.sort
    if sort.column == column
      sort.descending = !sort.descending;
    else
      sort.column = column;
      sort.descending = false;
]