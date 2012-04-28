
// helper function to display a message
function displayMessage(text, style) { 
	_$("message").innerHTML = "<p class='" + (style || "ok") + "'>" + text + "</p>"; 
} 

window.onload = function() {
    editableGrid = new EditableGrid("DemoGridJSON"); 
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
}