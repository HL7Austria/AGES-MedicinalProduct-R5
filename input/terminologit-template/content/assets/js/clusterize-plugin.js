function clusterizeTable(options) {

	var clusterizeTableParentDivId = options.parentDivId;
	var clusterizeTableClassName = options.classSelector;
	var hierarchical = options.hierarchical != 'undefined' && options.hierarchical != null ? options.hierarchical : false;

	if (document.getElementById(clusterizeTableParentDivId) == null) {
		return;
	}


	var parentDiv = document.getElementById(clusterizeTableParentDivId);
	var selectedTables = parentDiv.getElementsByClassName(clusterizeTableClassName);
	var parentPanelDivFixedHeight =  500;
	var parentPanelDivHeightForNoData = 150;
	var domTbodyFixedHeight =  360;
	var bottomScrollHeight = 17;
	var restrictedMinHeightForPanelDiv = 180;

	Array.from(selectedTables).forEach((contentTable, index) => {
		var uniqueIdSuffix = clusterizeTableClassName + '_' + clusterizeTableParentDivId + '_' + index;
		var firstCellOfHeaderValue = contentTable.getElementsByTagName('tbody')[0].childNodes[0].cells[0].innerHTML.replace(/(<([^>]+)>)/ig, '');
		var tableData = contentTable.getElementsByTagName('tbody')[0].innerHTML;
		var tableRowData = tableData.split('</tr>');
		var j = 1;
		for (var i = 0; i < tableRowData.length; i++) {
			if (tableRowData[i].slice(-1) != '</tr>') {
				tableRowData[i] = tableRowData[i] + '</tr>';
				if (i > 0 && hierarchical == true && firstCellOfHeaderValue.toLowerCase() == 'level') {
					var tableDataArray = tableRowData[i].split('</td>');
					var level = tableDataArray[0].toString().replace(/(<([^>]+)>)/ig, '');

					if (level.trim() == '1') {
						if (j % 2 === 0)
							tableDataArray[0] = '<tr data-level="' + level.trim() + '" style="background-color: #f5f9fc;"><td ' + (parseInt(tableRowData[i + 1].split('</td>')[0].toString().replace(/(<([^>]+)>)/ig, '')) > parseInt(level) ? 'class="closed"' : "") + ' onclick="toggleElement(this)">' + level
						else
							tableDataArray[0] = '<tr data-level="' + level.trim() + '" style="background-color: #ebf3f9;"><td ' + (parseInt(tableRowData[i + 1].split('</td>')[0].toString().replace(/(<([^>]+)>)/ig, '')) > parseInt(level) ? 'class="closed"' : "") + ' onclick="toggleElement(this)">' + level
						j += 1;
					} else if (level.trim() == '2' && parseInt(tableRowData[i + 1].split('</td>')[0].toString().replace(/(<([^>]+)>)/ig, '')) > parseInt(level)) {
						tableDataArray[0] = '<tr data-level="' + level.trim() + '" hidden><td ' + (parseInt(tableRowData[i + 1].split('</td>')[0].toString().replace(/(<([^>]+)>)/ig, '')) > parseInt(level) ? 'class="closed"' : "") + ' onclick="toggleElement(this)">' + level
					} else if (level.trim() == '3' && parseInt(tableRowData[i + 1].split('</td>')[0].toString().replace(/(<([^>]+)>)/ig, '')) > parseInt(level)) {
						tableDataArray[0] = '<tr data-level="' + level.trim() + '" hidden><td ' + (parseInt(tableRowData[i + 1].split('</td>')[0].toString().replace(/(<([^>]+)>)/ig, '')) > parseInt(level) ? 'class="closed"' : "") + ' onclick="toggleElement(this)">' + level
					} else {
						tableDataArray[0] = '<tr data-level="' + level.trim() + '" hidden><td class="open" onclick="toggleElement(this)">' + level
					}
					tableRowData[i] = tableDataArray.join('</td>');

				}
			}
		}


		var clusterizePanel = document.createElement('div'); //'<div class="panel th">'
		clusterizePanel.className = 'panel th';

		var clusterizeDivEl = '<div class="clusterize">' +
			'<input type="text" placeholder="Type here for search" class="form-control search-table" id="search_' + uniqueIdSuffix + '">' +
			'<div class="clusterize-headers">' +
			'<table class="fixed-header" id="headersArea_' + uniqueIdSuffix + '"></table>' +
			'</div>' +
			'<div id="scrollArea_' + uniqueIdSuffix + '" class="clusterize-scroll">' +
			'<table class="' + clusterizeTableClassName + ' clusterize-table" id="contentTable_' + uniqueIdSuffix + '">' +
			'<thead id="hiddenHeader_' + uniqueIdSuffix + '">' + tableRowData[0] + '</thead>' +
			'<tbody id="domContentArea_' + uniqueIdSuffix + '" style="width: 100%;"></tbody></table>' +
			'</div>' +
			'</div>';

		clusterizePanel.innerHTML = clusterizeDivEl


		//var tableHeaderData = tableRowData[0]
		tableRowData = tableRowData.splice(1, tableRowData.length);
		//contentTable.innerHTML = "<tbody id='domContentArea'></tbody>";
		//contentTable.style.display = "";
		contentTable?.replaceWith?.(clusterizePanel);

		document.getElementById("contentTable_" + uniqueIdSuffix).style.display = "table";

		// Below Codes are for setting header in sync with table body

		var $scroll = $("#scrollArea_" + uniqueIdSuffix);
		var $content = $('#domContentArea_' + uniqueIdSuffix);
		var $hiddenHeader = $("#hiddenHeader_" + uniqueIdSuffix);
		var $headers = $("#headersArea_" + uniqueIdSuffix);

		//$headers.html('<thead style="min-width:100%">'+ $hiddenHeader.html() + '</thead>');

		/**
		 * Makes header columns equal width to content columns
		 */
		var fitHeaderColumns = (function () {
			var prevWidth = [];
			return function () {
				var $firstRow = $hiddenHeader.find('tr'); //$content.find('tr:not(.clusterize-extra-row):first');
				var columnsWidth = [];

				var numberOfChildrens = $firstRow.children().length;
				$firstRow.children().each(function (index) {
					//columnsWidth.push($(this).width());
					if(index == numberOfChildrens - 1)
					{
						if($("#contentTable_" + uniqueIdSuffix).prop("scrollHeight") > $scroll.height())
						{
							columnsWidth.push($(this).outerWidth() + 17);
						}
						else
						{
							columnsWidth.push($(this).outerWidth());
						}
					}
					{
						columnsWidth.push($(this).outerWidth());
					}
				});
				//if (columnsWidth.toString() == prevWidth.toString()) return;
				$headers.find('tr').children().each(function (i) {
					//$(this).width(columnsWidth[i]);
					$(this).outerWidth(columnsWidth[i]);
				});
				//prevWidth = columnsWidth;
			}
		})();

		/**
		 * Keep header equal width to tbody
		 */
		var setHeaderWidth = function () {
			//$headers.width($content.width());
			$headers.outerWidth($content.outerWidth());
		}

		/**
		 * Set left offset to header to keep equal horizontal scroll position
		 */
		var setHeaderLeftMargin = function (scrollLeft) {
			$headers.css('margin-left', -scrollLeft);
		}

		var updateHeader = function () {
			$("#headersArea_" + uniqueIdSuffix).html('');
			$("#headersArea_" + uniqueIdSuffix).html('<thead>' + $("#hiddenHeader_" + uniqueIdSuffix).html() + '</thead>');
			$("#hiddenHeader_" + uniqueIdSuffix).css('visibility', 'hidden');
			$('#contentTable_' + uniqueIdSuffix).css('margin-top', -($("#hiddenHeader_" + uniqueIdSuffix).outerHeight()))
			fitHeaderColumns();
			setHeaderWidth();
		}

		// header sync code ends

		var clusterize = new Clusterize({
			rows: tableRowData,
			scrollId: 'scrollArea_' + uniqueIdSuffix,
			contentId: 'domContentArea_' + uniqueIdSuffix,
			rows_in_block: options.hierarchical != 'undefined' && options.hierarchical != null ? tableRowData.length : 200,
			blocks_in_cluster: 4,
			show_no_data_row: true,
			no_data_text: 'Loading Data...',
			callbacks: {
				clusterChanged: function () {
					setTimeout(updateHeader(), 1000);
				}
			}
		});

		// Following code has been added to make parent panel div height auto
		// in case of rows number are less than 9 and table height is less than
		// 500px so to prvent white spaces coming below the clusterize table
		if(clusterize.getRowsAmount() < 9) {
			$(clusterizePanel).css('height','auto');
		}

		var search = document.getElementById('search_' + uniqueIdSuffix);

		//var searchData = Object.assign([], tableRowData);

		var parseChildNodesForStringMatch = function (elem, query) {
			if (elem.getElementsByTagName('td').length > 0) {
				var tdCollection = elem.getElementsByTagName('td');
				for (var i = 0; i < tdCollection.length; i++) {
					let child = tdCollection[i];
					const keywordRegex = RegExp(query, 'gi');
					if (keywordRegex.test(child.textContent)) {
						return true
					}
				}
			}

			return false;
		};

		var htmlStringMatchesQuery = (str, query) => {

			let tempTable = document.createElement('table');
			tempTable.innerHTML = str;

			return parseChildNodesForStringMatch(tempTable, query);
		};

		let timer;              // Timer identifier
		//   let waitTime = 16;   // Wait time in milliseconds

		var onSearch = function () {
			waitTime = tableRowData.length / 16;
			clusterize.clear();
			clusterize.update([]);
			clearTimeout(timer);
			timer = setTimeout(() => {
				var searchData = [];
				var domCArea = document.getElementById('domContentArea_' + uniqueIdSuffix)
				var parentPanelDiv = findParentBySelector(domCArea, ".panel.th");

				if (search.value.trim() == "") {
					clusterize.clear();
					searchData = Object.assign([], tableRowData);
					clusterize.update(tableRowData);

					parentPanelDiv.style.height = "500px";
					parentPanelDiv.style.minHeight  = restrictedMinHeightForPanelDiv + "px";
					parentPanelDiv.style.resize  = "both";

				} else {

					for (var j = 0, jj = tableRowData.length; j < jj; j++) {
						//if (tableRowData[j].toString().toLowerCase().indexOf(search.value.toLowerCase().trim()) + 1) {
						if (htmlStringMatchesQuery(tableRowData[j], search.value.trim())) {
							var fileredRow = tableRowData[j];

							/******************************************************************/
							/* In case of table with level we need to remove toggle behaviour */
							/******************************************************************/
							if(hierarchical) {
								var fileredRowDataArray = fileredRow.split('</td>');
								var level = fileredRowDataArray[0].toString().replace(/(<([^>]+)>)/ig, '');
								fileredRowDataArray[0] = '<tr><td>' + level
								fileredRow = fileredRowDataArray.join('</td>');
							}

							searchData.push(fileredRow);
						}
					}

					clusterize.clear();
					clusterize.update(searchData);



					var domTbodyHeight = document.getElementById('domContentArea_' + uniqueIdSuffix).offsetHeight;
					if(domTbodyHeight < 360) {
						/********************************************/
						var parentPanelDivHeight = parentPanelDivFixedHeight - (domTbodyFixedHeight - (domTbodyHeight + ($content.outerWidth() > $scroll.outerWidth() ? bottomScrollHeight : 0)));
						parentPanelDiv.style.height =   parentPanelDivHeight + "px";
						//parentPanelDiv.style.minHeight  = parentPanelDivHeight > 180 ? "180px" : parentPanelDivHeight + "px";
						parentPanelDiv.style.resize  = "none";
					} else if (parentPanelDiv.offsetHeight < parentPanelDivFixedHeight) {
						//parentPanelDiv.style.height =   parentPanelDivFixedHeight - (domTbodyFixedHeight - (domTbodyHeight + ($content.outerWidth() > $scroll.outerWidth() ? bottomScrollHeight : 0))) + "px";
						parentPanelDiv.style.height =   parentPanelDivFixedHeight + "px";
						parentPanelDiv.style.minHeight  = restrictedMinHeightForPanelDiv;
						parentPanelDiv.style.resize  = "both";
					}

					highlight(document.getElementById('domContentArea_' + uniqueIdSuffix), [search.value]);

				}
				if (searchData.length == 0) {

					domCArea.getElementsByClassName('clusterize-no-data')[0]
						.getElementsByTagName('td')[0].innerHTML = 'No Data Found';

					parentPanelDiv.style.height = parentPanelDivFixedHeight - (domTbodyFixedHeight - (domTbodyHeight + ($content.outerWidth() > $scroll.outerWidth() ? bottomScrollHeight : 0)));
					parentPanelDiv.style.minHeight  = parentPanelDiv.style.height + "px";//"185px";
					parentPanelDiv.style.resize  = "none";

				}
			}, waitTime);

		}

		search.oninput = onSearch;



		/**
		 * Update header columns width on window resize
		 */

		$(window).resize(_.debounce(fitHeaderColumns, 150));

		/**
		 * Update header left offset on scroll
		 */
		$scroll.on('scroll', (function () {
			var prevScrollLeft = 0;
			return function () {
				var scrollLeft = $(this).scrollLeft();
				if (scrollLeft == prevScrollLeft) return;
				prevScrollLeft = scrollLeft;

				setHeaderLeftMargin(scrollLeft);

			}
		}()));

	});


	/**
	 * Highlight keywords inside a DOM element
	 * @param {string} elem Element to search for keywords in
	 * @param {string[]} keywords Keywords to highlight
	 * @param {boolean} caseSensitive Differenciate between capital and lowercase letters
	 * @param {string} cls Class to apply to the highlighted keyword
	 */
	function highlight(elem, keywords, caseSensitive = true, cls = 'highlight') {
		const flags = caseSensitive ? 'gi' : 'g';
		// Sort longer matches first to avoid
		// highlighting keywords within keywords.
		keywords.sort((a, b) => b.length - a.length);
		Array.from(elem.childNodes).forEach(child => {
			const keywordRegex = RegExp(keywords.join('|'), flags);
			if (child.nodeType !== 3) { // not a text node
				highlight(child, keywords, caseSensitive, cls);
			} else if (keywordRegex.test(child.textContent)) {
				const frag = document.createDocumentFragment();
				let lastIdx = 0;
				child.textContent.replace(keywordRegex, (match, idx) => {
					const part = document.createTextNode(child.textContent.slice(lastIdx, idx));
					const highlighted = document.createElement('span');
					highlighted.textContent = match;
					highlighted.classList.add(cls);
					frag.appendChild(part);
					frag.appendChild(highlighted);
					lastIdx = idx + match.length;
				});
				const end = document.createTextNode(child.textContent.slice(lastIdx));
				frag.appendChild(end);
				child.parentNode.replaceChild(frag, child);
			}
		});
	}




}

(function ($) {
	var settings = {
		visiblerows: 5
	};

	$.fn.hideRows = function (options) {
		"use strict";

		settings = $.extend(settings, options);

		const selectedTables = $(this);

		Array.from(selectedTables).forEach((table, index) => {
			var propertyTag = $(table).prevAll().filter(function(elem) {
				return ($(this).children().text().toLowerCase()== "properties");
			});
			//console.log(propertyTag);
			if (propertyTag.length > 0 && $(propertyTag).children() != undefined && $(propertyTag).children().text().toLowerCase() == "properties") {
				var selectedTbody = $(table).find("tbody");
				var childRows = $(selectedTbody).find("tr");
				var colspan = childRows.length > 0 ? childRows[0].children.length : 0;

				if (childRows.length > settings.visiblerows + 1) {
					var anchorRow = "<tr><td colspan=\"" + colspan + "\"><a href=\"javascript:void(0)\">▼ Show more properties</a></td></tr>";

					$(selectedTbody[0].lastElementChild).after(anchorRow);

					$(selectedTbody[0].lastElementChild).addClass("anchorRow");

					$(selectedTbody[0].lastElementChild).find("a").addClass("anchor");

					$(selectedTbody[0].lastElementChild).find("a").attr('onClick', '$.fn.showMoreRows(this);return false;');

					Array.from(childRows).forEach((element, index) => {
						if (index > settings.visiblerows && index < childRows.length)
							element.classList.add("hidden");
					});
				}
			}
		});
	};

	$.fn.showMoreRows = function (target) {

		$(target).text("▲ Show less properties");

		$(target).attr('onClick', '$.fn.showLessRows(this)');

		$(target).parents("tbody").find("tr").removeClass("hidden");

	};

	$.fn.showLessRows = function (target) {

		$(target).text("▼ Show more properties");

		$(target).attr('onClick', '$.fn.showMoreRows(this)');

		$(target).parents("tbody").find("tr").slice(settings.visiblerows + 1, $(target).parents("tbody").find("tr").length - 1).addClass("hidden");
	};

}(jQuery));


var resetHeaderColumnWidth = function (tbody) {

	var parentPanelDiv = findParentBySelector(tbody, ".panel.th");
	var clusterizeTable = parentPanelDiv.getElementsByClassName('clusterize-table')[0];
	//console.log(clusterizeTable);
	var columnsWidth = [];
	var firstRow = clusterizeTable.getElementsByTagName('thead')[0].getElementsByTagName('tr')[0]

	//console.log($(firstRow));
	var numberOfChildrens = $(firstRow).children().length;
	$(firstRow).children().each(function (index) {
		//columnsWidth.push($(this).width());
		if(index == numberOfChildrens - 1)
		{
			if($(clusterizeTable).prop("scrollHeight") > $(clusterizeTable).closest('.clusterize-scroll').height())
			{
				columnsWidth.push($(this).outerWidth() + 17);
			}
			else
			{
				columnsWidth.push($(this).outerWidth());
			}
		}
		{
			columnsWidth.push($(this).outerWidth());
		}
	});
	//if (columnsWidth.toString() == prevWidth.toString()) return;
	$(parentPanelDiv).find('.fixed-header').find('thead').find('tr').children().each(function (i) {
		//$(this).width(columnsWidth[i]);
		$(this).outerWidth(columnsWidth[i]);
	});
	//prevWidth = columnsWidth;

};

var collectionHas = function (a, b) { //helper function (see below)
	for(var i = 0, len = a.length; i < len; i ++) {
		if(a[i] == b) return true;
	}
	return false;
}
var findParentBySelector = function (elm, selector) {
	var all = document.querySelectorAll(selector);
	var cur = elm.parentNode;
	while(cur && !collectionHas(all, cur)) { //keep going up until you find a match
		cur = cur.parentNode; //go up
	}
	return cur; //will return null if not found
}

var setClusterizeHeight = function(tbody) {

	var parentPanelDiv = findParentBySelector(tbody, ".panel.th");

	var visibleRowsLength = Array.from(tbody.childNodes).filter((el)=>{
		return el.hidden == false;
	}).length;

	if(visibleRowsLength < 9) {
		var parentPanelDivHeight = (150 +  visibleRowsLength * 42.79);
		parentPanelDiv.style.height =   parentPanelDivHeight + "px";
		parentPanelDiv.style.minHeight  = parentPanelDivHeight > 180 ? "180px" : parentPanelDivHeight + "px";
		parentPanelDiv.style.resize  = "none";
	} else if (parentPanelDiv.style.height < 500){
		parentPanelDiv.style.height = "500px";
		parentPanelDiv.style.minHeight  = "180px";
		parentPanelDiv.style.resize  = "both";
	}


}

var toggleElement = function (context) {
	if (context.className == "opened") {
		context.className = "closed"
		toggleChildren(context.parentElement, true)
	} else if (context.className == "closed") {
		context.className = "opened";
		toggleChildren(context.parentElement, false)
	}

	//let current = context.parentElement

	/*if (current.getAttribute('data-level') == '1') {
		toggleLevel1(current);
	} else if (current.getAttribute('data-level') == '2') {
		toggleLevel2(current);
	} else if (current.getAttribute('data-level') == '3') {
		toggleLevel3(current);
	}*/



};

/*var toggleLevel1 = function (current) {
	let nextSibling = current.nextElementSibling;

	while (nextSibling && nextSibling.getAttribute('data-level') == '2') {
		nextSibling.hidden = nextSibling.hidden ? false : true
		if(nextSibling.hidden && nextSibling.childNodes.length > 0 && parseInt(nextSibling.nextElementSibling.getAttribute('data-level')) > 2 ) {
			nextSibling.childNodes[0].setAttribute("class","closed");
		}

		nextSibling = nextSibling.nextElementSibling
		while (nextSibling && nextSibling.getAttribute('data-level') == '3') {
			nextSibling.hidden = nextSibling.hidden ? false : true
			if(nextSibling.hidden && nextSibling.childNodes.length > 0 && parseInt(nextSibling.nextElementSibling.getAttribute('data-level')) > 2 ) {
				nextSibling.childNodes[0].setAttribute("class","closed");
			} else if (!nextSibling.hidden) {
				nextSibling.hidden = nextSibling.hidden ? false : true
			}

			nextSibling = nextSibling.nextElementSibling
			while (nextSibling && nextSibling.getAttribute('data-level') == '4') {
				if(nextSibling.hidden && nextSibling.childNodes.length > 0 && parseInt(nextSibling.nextElementSibling.getAttribute('data-level')) > 2 ) {
					nextSibling.childNodes[0].setAttribute("class","closed");
				} else if (!nextSibling.hidden) {
					nextSibling.hidden = nextSibling.hidden ? false : true
				}
				nextSibling = nextSibling.nextElementSibling
			}
		}
	}

	setClusterizeHeight(current.parentElement);
	setTimeout(setHierarchicalTableBgColor(current.parentElement,0),150);
	setTimeout(resetHeaderColumnWidth(current.parentElement),150);
};

var toggleLevel2 = function (current) {
	let nextSibling = current.nextElementSibling;

	while (nextSibling && nextSibling.getAttribute('data-level') == '3') {
		nextSibling.hidden = nextSibling.hidden ? false : true
		if(nextSibling.hidden && nextSibling.childNodes.length > 0 && parseInt(nextSibling.nextElementSibling.getAttribute('data-level')) > 2 ) {
			nextSibling.childNodes[0].setAttribute("class","closed");
		}

		nextSibling = nextSibling.nextElementSibling
		while (nextSibling && nextSibling.getAttribute('data-level') == '4') {
			if(nextSibling.hidden && nextSibling.childNodes.length > 0 && parseInt(nextSibling.nextElementSibling.getAttribute('data-level')) > 2 ) {
				nextSibling.childNodes[0].setAttribute("class","closed");
			} else if (!nextSibling.hidden) {
				nextSibling.hidden = nextSibling.hidden ? false : true
			}
			nextSibling = nextSibling.nextElementSibling
		}
	}

	setClusterizeHeight(current.parentElement);
	setTimeout(setHierarchicalTableBgColor(current.parentElement,0),150);
	setTimeout(resetHeaderColumnWidth(current.parentElement),150);
};

var toggleLevel3 = function (current) {
	let nextSibling = current.nextElementSibling;

	while (nextSibling && nextSibling.getAttribute('data-level') == '4') {
		nextSibling.hidden = nextSibling.hidden ? false : true
		nextSibling = nextSibling.nextElementSibling
	}

	setClusterizeHeight(current.parentElement);
	setTimeout(setHierarchicalTableBgColor(current.parentElement,0),150);
	setTimeout(resetHeaderColumnWidth(current.parentElement),150);
};*/

//this method toggles the children on or off, including a sliding motion
var toggleChildren = function(row, display){
	allRows = $(row).parent().find('tr');

	for(var i = $(row).index();i < allRows.length; i++){
		if(!display && $(row).data('level')+1 == $(allRows[i+1]).data('level') || display && $(row).data('level') < $(allRows[i+1]).data('level')) {
			if (display) {
				$(allRows[i+1]).attr('hidden', true);
				$(allRows[i+1]).find('.opened').removeClass('opened').addClass('closed')
			} else {
				$(allRows[i+1]).removeAttr('hidden');
			}
		} else if (display || $(row).data('level') == $(allRows[i+1]).data('level')) {
			break;
		}
	}
}

function setHierarchicalTableBgColor(tbody, startIndex) {
	var j=0;
	for (var i = startIndex; i < tbody.childNodes.length; i++) {
		if (j === 0 || j % 2 === 0 && tbody.childNodes[i].hidden == false) {
			tbody.childNodes[i].setAttribute('style','background-color:#f5f9fc');
			j++;
		}
		else if (tbody.childNodes[i] != null && tbody.childNodes[i].hidden == false) {
			tbody.childNodes[i].setAttribute('style','background-color:#ebf3f9');
			j++;
		}

	}
}


$(document).ready(function () {
	$("#terminologit-search-content-valueset-cld").addClass("accordion-group");
	//$("#terminologit-search-content-valueset-cld").attr("id","logical-definition-accordion-group");
	var logicalDefHeading = $("#terminologit-search-content-valueset-cld").find("#logical-definition-cld");
	$(logicalDefHeading).addClass("accordion-heading");
	$(logicalDefHeading).append('<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion1" href="#logical-definition-cld-collapse"><i class="gg-chevron-down"></i></a>');
	$(logicalDefHeading).next().addClass("accordion-body collapse");
	$(logicalDefHeading).next().attr('id', 'logical-definition-cld-collapse');

	$('.gg-chevron-down').each(function () {
		$(this).click(function () {
			jQuery(this).toggleClass("rotate-toggle");
		});
	});

	$('#terminologit-search-content-valueset-cld').on('shown.bs.collapse', function () {
		$(this).find('.clusterize-table').each(function(){
			//console.log($(this).find('tbody'));
			setTimeout(resetHeaderColumnWidth($(this).find('tbody')[0]),150);
			$(this).css('margin-top', -41)
		});
	})
});