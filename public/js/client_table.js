
// helper function to display a message
function displayMessage(text, style) { 
	_$("message").innerHTML = "<p class='" + (style || "ok") + "'>" + text + "</p>"; 
} 

// helper function to get path of a demo image
function image(relativePath) {
	return "img/" + relativePath;
}

window.onload = function() {
    editableGrid = new EditableGrid("DemoGridJSON", {
	pageSize: 10,
    }
); 
    editableGrid.tableLoaded = function() { this.renderGrid("tablecontent", "testgrid"); };
    editableGrid.loadJSON("/clients.json");
    
    // register the function that will handle model changes
    editableGrid.modelChanged = function(rowIndex, columnIndex, oldValue, newValue) {

	$.ajax({

            url: "/client/update",

            type: 'POST',

            dataType: "json",

            data: {
		id: editableGrid.getRowId(rowIndex),
		column: columnIndex,
		value: newValue
            },

            success: function (response) {
		// reset old value if failed
		// if (response != "ok") editableGrid.setValueAt(rowIndex, columnIndex, oldValue);
		// here you could also highlight the updated row to give the user some feedback
		displayMessage("Value for '" + editableGrid.getColumnName(columnIndex) + "' in row " + editableGrid.getRowId(rowIndex) + " has changed from '" + oldValue + "' to '" + newValue + "'");
            },

            error: function(XMLHttpRequest, textStatus, exception) {
		alert(XMLHttpRequest.responseText);
            }
	});

    };


    // set active (stored) filter if any
    _$('filter').value = editableGrid.currentFilter ? editableGrid.currentFilter : '';
    
    // filter when something is typed into filter
    _$('filter').onkeyup = function() {editableGrid.filter(_$('filter').value); };

    // update paginator whenever the table is rendered (after a sort, filter, page change, etc.)
    editableGrid.tableRendered = function() { this.updatePaginator(); };

}

// function to render the paginator control
EditableGrid.prototype.updatePaginator = function()
{
	var paginator = $("#paginator").empty();
	var nbPages = this.getPageCount();

	// get interval
	var interval = this.getSlidingPageInterval(20);
	if (interval == null) return;
	
	// get pages in interval (with links except for the current page)
	var pages = this.getPagesInInterval(interval, function(pageIndex, isCurrent) {
		if (isCurrent) return "" + (pageIndex + 1);
		return $("<a>").css("cursor", "pointer").html(pageIndex + 1).click(function(event) { editableGrid.setPageIndex(parseInt($(this).html()) - 1); });
	});
		
	// "first" link
	var link = $("<a>").html("<img src='" + image("gofirst.png") + "'/>&nbsp;");
	if (!this.canGoBack()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.firstPage(); });
	paginator.append(link);

	// "prev" link
	link = $("<a>").html("<img src='" + image("prev.png") + "'/>&nbsp;");
	if (!this.canGoBack()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.prevPage(); });
	paginator.append(link);

	// pages
	for (p = 0; p < pages.length; p++) paginator.append(pages[p]).append(" | ");
	
	// "next" link
	link = $("<a>").html("<img src='" + image("next.png") + "'/>&nbsp;");
	if (!this.canGoForward()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.nextPage(); });
	paginator.append(link);

	// "last" link
	link = $("<a>").html("<img src='" + image("golast.png") + "'/>&nbsp;");
	if (!this.canGoForward()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.lastPage(); });
	paginator.append(link);
};
