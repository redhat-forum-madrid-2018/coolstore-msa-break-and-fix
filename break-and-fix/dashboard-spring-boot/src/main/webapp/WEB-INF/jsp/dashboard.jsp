<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
	<title>Red Hat Forum 2018</title>
	<!-- PatternFly Styles -->
	<link rel="stylesheet" href="/node_modules/patternfly/dist/css/patternfly.min.css">
	<link rel="stylesheet" href="/node_modules/patternfly/dist/css/patternfly-additions.min.css">
	
	<!-- JS -->
	<script src="/node_modules/jquery/dist/jquery.min.js"></script>
	<script src="/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
	
	<!-- C3, D3 - Charting Libraries -->
	<script src="/node_modules/d3/d3.min.js"></script>
	<script src="/node_modules/c3/c3.min.js"></script>
	
	<script src="/node_modules/jquery-match-height/dist/jquery.matchHeight-min.js"></script>

	<script src="/node_modules/datatables.net/js/jquery.dataTables.js"></script>
	<script src="/node_modules/patternfly/dist/js/patternfly.min.js"></script>
</head>
<body>
<!-- Horizontal Navigation -->
<nav class="navbar navbar-default navbar-pf" role="navigation">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse-1">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="/">
      <img src="/img/logo.png" alt="Red Hat" />
    </a>    
  </div>
  <div class="collapse navbar-collapse navbar-collapse-1">
    <ul class="nav navbar-nav navbar-primary">
      <li>
        <a href="/">The Challenge</a>
      </li>
      <li>
        <a href="/challenge/signin">Start the challenge</a>
      </li>
      <li class="active">
        <a href="/dashboard/">Dashboard</a>
      </li>
    </ul>
  </div>
</nav>
<br/>

<!-- Table HTML -->
<table class="table table-striped table-bordered table-hover" id="table1">
  <thead>
    <tr>
      <th>Name</th>
      <th>Company</th>
      <th>Time</th>
    </tr>
  </thead>
</table>

<script>
$(document).ready(function() {

// JSON data for Table View
var dataSet = [
<c:forEach var="competitor" items="${competitors}">
	{
	    name: "${competitor.fullName}",
	  	company: "${competitor.company}",
	  	time: "${competitor.timeFormatted}"
	},
</c:forEach>	
	{
	    name: "Red Hat Forum 2018",
	  	company: "Red Hat",
	  	time: "99999999999999"
	}
];

// DataTable Config
$("#table1").DataTable({
  columns: [
    { data: "name" },
    { data: "company" },
    { data: "time" }
  ],
  data: dataSet,
  dom: "t",
  language: {
    zeroRecords: "No records found"
  },
  order: [[ 2, 'asc' ]],
  pfConfig: {
    emptyStateSelector: "#emptyState1",
    filterCaseInsensitive: true,
    filterCols: [
      null,
      {
        default: true,
        optionSelector: "#filter1",
        placeholder: "Filter By Rendering Engine..."
      }, {
        optionSelector: "#filter2",
        placeholder: "Filter By Browser..."
      }, {
        optionSelector: "#filter3",
        placeholder: "Filter By Platform(s)..."
      }, {
        optionSelector: "#filter4",
        placeholder: "Filter By Engine Version..."
      }, {
        optionSelector: "#filter5",
        placeholder: "Filter By CSS Grade..."
      }
    ],
    paginationSelector: "#pagination1",
    toolbarSelector: "#toolbar1",
    selectAllSelector: 'th:first-child input[type="checkbox"]',
    colvisMenuSelector: '.table-view-pf-colvis-menu'
  },
  select: {
    selector: 'td:first-child input[type="checkbox"]',
    style: 'multi'
  },
});

/**
 * Utility to show empty Table View
 *
 * @param {object} config - Config properties associated with a Table View
 * @param {object} config.data - Data set for DataTable
 * @param {string} config.deleteRowsSelector - Selector for delete rows control
 * @param {string} config.restoreRowsSelector - Selector for restore rows control
 * @param {string} config.tableSelector - Selector for the HTML table
 */
var emptyTableViewUtil = function (config) {
  var self = this;

  this.dt = $(config.tableSelector).DataTable(); // DataTable
  this.deleteRows = $(config.deleteRowsSelector); // Delete rows control
  this.restoreRows = $(config.restoreRowsSelector); // Restore rows control

  // Handle click on delete rows control
  this.deleteRows.on('click', function() {
    self.dt.clear().draw();
    $(self.restoreRows).prop("disabled", false);
  });

  // Handle click on restore rows control
  this.restoreRows.on('click', function() {
    self.dt.rows.add(config.data).draw();
    $(this).prop("disabled", true);
  });

  // Initialize restore rows
  if (this.dt.data().length === 0) {
    $(this.restoreRows).prop("disabled", false);
  }
};

// Initialize empty Table View util
new emptyTableViewUtil({
  data: dataSet,
  deleteRowsSelector: "#deleteRows1",
  restoreRowsSelector: "#restoreRows1",
  tableSelector: "#table1"
});

/**
 * Utility to find items in Table View
 */
var findTableViewUtil = function (config) {
  // Upon clicking the find button, show the find dropdown content
  $(".btn-find").click(function () {
    $(this).parent().find(".find-pf-dropdown-container").toggle();
  });

  // Upon clicking the find close button, hide the find dropdown content
  $(".btn-find-close").click(function () {
    $(".find-pf-dropdown-container").hide();
  });
};

// Initialize find util
new findTableViewUtil();

});
</script>

<script>
	// Initialize Datatables
	$(document).ready(function() {
		$('.datatable').dataTable();
	});
</script>

</body>
</html>
