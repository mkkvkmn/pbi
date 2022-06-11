let theme = {
    "name": "themeName",
    "textClasses": {
        "label": {
            "fontFace": "selectedFont"
        },
        "title": {
            "fontFace": "selectedFont",
            "fontSize": 10
        },
        "header": {
            "fontFace": "selectedFont"
        },
        "callout": {
            "fontFace": "selectedFont"
        }
    },
    "dataColors": [
        "color1",
        "color2",
        "color3",
        "color4",
        "color5",
        "color6",
        "color7",
        "color8"
    ],
    "good": "goodColor",
    "maximum": "goodColor",
    "neutral": "neutralColor",
    "center": "neutralColor",
    "bad": "badColor",
    "minimum": "badColor",
    "visualStyles": {
        "slicer": {
			"*": {
				"general": [{
					"outlineWeight": 0,
					"responsive": false
				}],
				"background": [{
					"show": false,
					"color": {"solid": {"color": ""}},
					"transparency": 0
				}],
				"data": [{
					"mode": "Dropdown", //doesn't seem to work, though it should
				}],
				"selection": [{
					"selectAllCheckboxEnabled": true,
					"singleSelect": false
				}],
				"header": [{
					"show": true,
					"fontColor": { "solid": { "color": "textColor"}},
					"background": { "solid": { "color": ""}},
					"outline": "None"
				}],
				"items": [{
					"fontColor": { "solid": { "color": "textColor"}},
					"background": { "solid": { "color": "slicerItemBgColor"}},
					"outline": "None"
				}],
				"slider": [{ 
					"color": {"solid": { "color": "textColor"} }
				}]
			}
		},
        "card": {
			"*": {
				"labels": [{
					"color": { "solid": { "color": "textColor"}},
					"labelDisplayUnits": "0",
					"labelPrecision": 0,
					"fontSize": 25,
				}],
				"categoryLabels": [{
					"show": true,
					"color": { "solid": { "color": "textColor"}},
				}],
				"wordWrap": [{
					"show": false
				}],
                "border": [{
                "show": false,
                "color": { "solid": { "color": ""}}
                }]
			}
		},
        "pivotTable": {
			"*": {
				"stylePreset":[{"name":"themeName"}],
				"grid": [{
					"gridVertical": false,
					"gridVerticalColor": { "solid": { "color": ""}},
					"gridVerticalWeight": 1,
					"gridHorizontal": false,
					"gridHorizontalColor": { "solid": { "color": ""}},
					"gridHorizontalWeight": 1,
					"rowPadding": 1,
					"outlineColor": { "solid": { "color": ""}},
					"outlineWeight": 0,
					"imageHeight": 100
				}],
				"columnHeaders": [{
					"fontColor": { "solid": { "color": "textColor"}},
					"backColor": { "solid": { "color": ""}},
					"outline": "Bottom only",
					"autoSizeColumnWidth": false,
					"alignment": "Right",
					"titleAlignment": "Right",
					"urlIcon": true,
					"wordWrap": true
				}],
				"rowHeaders": [{
					"fontColor": { "solid": { "color": "textColor"}},
					"backColor": { "solid": { "color": ""}},
					"outline": "None",
					"stepped": true,					
					"urlIcon": true,
					"wordWrap": false,
					"alignment": "Left", 
					"showExpandCollapseButtons":true
				}],
				"values": [{
					"fontColorPrimary": { "solid": { "color": "textColor"}},
					"backColorPrimary": { "solid": { "color": ""}},
					"fontColorSecondary": { "solid": { "color": "textColor"}},
					"backColorSecondary": { "solid": { "color": ""}},
					"bandedRowHeaders": true,
					"valuesOnRow": false,
					"outline": "None",
					"urlIcon": true,
					"wordWrap": false,
				}],
				"subTotals": [{
					"rowSubtotals": true,
					"columnSubtotals": true,
					"backColor": { "solid": { "color": ""}},
					"applyToHeaders": true,
					"rowSubtotalsPosition": "Top",
					"perRowLevel": true,
					"perColumnLevel": true					
				}],
				"total": [{
					"fontColor": { "solid": { "color": "textColor"}},
					"backColor": { "solid": { "color": ""}},
					"applyToHeaders": true,
					"fontSize": 10
				}]
			}
		},
        "tableEx": {
			"*": {
				"grid": [{
					"gridVertical": true,
					"gridVerticalColor": { "solid": { "color": "axisLabelandGridColor"}},
					"gridVerticalWeight": 1,
					"gridHorizontal": true,
					"gridHorizontalColor": { "solid": { "color": "axisLabelandGridColor"}},
					"gridHorizontalWeight": 1,
					"rowPadding": 2,
					"outlineColor": { "solid": { "color": "axisLabelandGridColor"}},
					"outlineWeight": 0,
					"textSize": 8,
					"imageHeight": 100
				}],
				"columnHeaders": [{
					"fontColor": { "solid": { "color": "textColor"}},
					"backColor": { "solid": { "color": "visualBgColor"}},
					"outline": "Bottom only",
					"autoSizeColumnWidth": false,
					"fontSize": 9,
					"alignment": "Left",
					"wordWrap": true
				}],
				"values": [{
					"fontColorPrimary": { "solid": { "color": "textColor"}},
					"backColorPrimary": { "solid": { "color": "visualBgColor"}},
					"fontColorSecondary": { "solid": { "color": "textColor"}},
					"backColorSecondary": { "solid": { "color": "secondaryBgColor"}},
					"outline": "None",
					"urlIcon": true,
					"wordWrap": false,
					"fontSize": 8
				}],
				"total": [{
					"totals": true,
					"fontColor": { "solid": { "color": "textColor"}},
					"backColor": { "solid": { "color": "visualBgColor"}},
					"outline": "Top only",
				}],
				"stylePreset": [{ 
					"name": "themeName"
				}]
			}
		},
        "page": {
            "*": {
                "background": [{
                    "color": { "solid": { "color": "pageBgAndFilterPaneBgColor" } },
                    "transparency": 0
                }],
                "outspace": [{
                    "color": { "solid": { "color": "pageBgAndFilterPaneBgColor" } },
                    "transparency": 0
                }],
                // This is the filter pane
                "outspacePane": [{
                    "backgroundColor": { "solid": { "color": "pageBgAndFilterPaneBgColor" } },
                    "foregroundColor": { "solid": { "color": "textColor" } }, // This is font color for general text in filter pane
                    "borderColor": { "solid": { "color": "#3e3e3e" } },
                    "border": true
                }],
                "filterCard": [{
                        "$id": "Applied",
                        "backgroundColor": { "solid": { "color": "appliedPageBgAndFilterPaneBgColor" } },
                        "foregroundColor": { "solid": { "color": "textColor" } },
                        "borderColor": { "solid": { "color": "#3e3e3e" } },
                        "inputBoxColor": { "solid": { "color": "appliedPageBgAndFilterPaneBgColor" } },
                        "border": true
                    },
                    {
                        "$id": "Available",
                        "backgroundColor": { "solid": { "color": "pageBgAndFilterPaneBgColor" } },
                        "foregroundColor": { "solid": { "color": "textColor" } },
                        "borderColor": { "solid": { "color": "#3e3e3e" } },
                        "inputBoxColor": { "solid": { "color": "appliedPageBgAndFilterPaneBgColor" } },
                        "border": true
                }]
            }
        },
        // General stuff for visuals
        "*": {
            "*": {
                "background": [{
                    "show": "showVisualBg",
                    "color": { "solid": {"color": "visualBgColor"}},
                    "transparency": "visualBgTransparency"
                }],
                "legend": [{
                    "labelColor": {"solid": {"color": "dataLabelColor"}}
                }],
                "title": [{
                    "show": true,
                    "fontColor": {"solid": { "color": "textColor" }},
                    "background": { "solid": { "color": "" }},
                    "fontSize": 12
                }],
                "categoryAxis": [{
                    "show": true,
                    "labelColor": { "solid": { "color": "axisLabelandGridColor" }},
                    "showAxisTitle": false,
                    "fontSize": 9
                }],
                "valueAxis": [{
                    "show": true,
                    "labelColor": { "solid": { "color": "axisLabelandGridColor" }},
                    "secLabelColor": { "solid": { "color": "axisLabelandGridColor"}},
                    "gridlineShow": true,
                    "gridlineColor": { "solid": { "color": "axisLabelandGridColor"}},
                    "showAxisTitle": false,
                    "alignZeros": true,
					"secFontSize": 9,
                    "fontSize": 9
                }],
                "labels": [{
                    "show": true,
                    "color": { "solid": {"color": "dataLabelColor" }},
                    "labelDisplayUnits": "0",
                    "labelPrecision": 1,
                    "enableBackground": true,
                    "backgroundColor": { "solid": { "color": "dataLabelBg" }},
                    "backgroundTransparency": 25,
                    "fontSize": 9
                }],
                "visualTooltip": [{
                    "titleFontColor": { "solid": { "color": "toolTipFontColor" }},
                    "valueFontColor": { "solid": { "color": "toolTipFontColor" }},
                    "background": { "solid": { "color": "toolTipBgColor" }}
                }],
                "border": [
                    {"show": false}
                ]
            }
        }
    }
}