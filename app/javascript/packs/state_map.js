const d3 = require('d3');
const stateMapUtils = require('./state_map_utils');

require('../stylesheets/map.scss');

$(document).ready(() => {
    const stateMap = new stateMapUtils.Map();
    d3.json(stateMap.topojsonUrl).then((topology) => {
        const mapAssets = stateMapUtils.parseTopojson(stateMap, topology);
        stateMap.svgElement.selectAll('path')
            .data(mapAssets.geojson.features)
            .enter()
            .append('path')
            .attr('class', 'actionmap-view-region')
            .attr('d', mapAssets.path)
            .attr('data-county-name', (d) => stateMap.counties[d.properties.COUNTYFP].name)
            .attr('data-county-fips-code', (d) => d.properties.COUNTYFP);
            // .on('click', function (event, d) {
            //     // Handle click event on county here
            //     const countyFIPS = d.properties.COUNTYFP;
            //     const newURL = `/state/${stateSymbol}/county/${countyFIPS}`;
            //     window.location.href = newURL;
            // });
        const clickCallback = (elem) => {
            const stateSymbol = elem.attr('data-state-symbol');
            const countySymbol = elem.attr('data-county-name')
            window.location.href = `/state/${stateSymbol}/${countySymbol}`;
        };
        stateMapUtils.setupEventHandlers(stateMap);
    });
});