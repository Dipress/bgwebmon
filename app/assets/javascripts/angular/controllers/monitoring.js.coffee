window.app.controller 'monitoringCtrl', ['$scope', '$http', 'Contract', ($scope, $http, Contract)->
  Contract.query {page: 1}, (data)->
    $scope.pagination = data.meta
    input = []
    for i in [1 .. $scope.pagination.total_pages]
      input.push(i)
    $scope.pagination.total_pages =  input;
    $scope.contracts = data.new_monitoring

  $scope.paginateContracts = ($event, page)->
    if $scope.term == undefined
      $scope.term = ''
    if $scope.bs_id == undefined
      $scope.bs_id = ''
    Contract.query {page: page, term: $scope.term, bs_id: $scope.bs_id}, (data)->
      $scope.pagination = data.meta
      input = []
      for i in [1 .. $scope.pagination.total_pages]
        input.push(i)
      $scope.pagination.total_pages =  input;
      $scope.contracts = data.new_monitoring


  $scope.getGraph = (id, ip, time)->
    $http( method: "GET", url: '/new_monitoring/'+ id + '?ip=' + ip + '&hour=' + time).success (data)->
      popup = new Popup($('div#popup'),$(window).height(),$(window).width())
      popup.ToggleIt()
      ea = new AjaxReq($('div#popupcontent'), $(this).attr('lid'))
      $(ea.ul).html('')
      $(ea.ul).append("<img src=\"" + data + "\"/>")
      popup.Resize()
]