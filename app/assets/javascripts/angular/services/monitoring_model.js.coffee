window.app.factory 'Contract', ['$resource', ($resource) ->
  $resource '/new_monitoring/:id', 
    { id: '@id' },
    query:
      { method: 'GET'
      , isArray: false }

]