(function() {
	"use strict";

	var svg_event = new CustomEvent('svg-loaded');

	var DataParser = (function() {
		return {
			load: function() {

				var words_data = d3.csv('sentiment.csv');

				words_data.row(function(d) {
					// console.log(d)
					return {
						handle : 'sentiment',
						negative_count: parseInt(d.negative),
						positive_count: parseInt(d.positive),
						neutral_count: parseInt(d.neutral),
					};
				}).get(function(error, word_rows) {
					var csv_event = new CustomEvent('csv-data-loaded', {detail: word_rows});

					document.dispatchEvent(csv_event);
				});
			}
		};
	})();

	var VisualizationHandler = (function () {
		return {
			plotDonut: function(raw_data) {
				$(function () {
					$('#visualization').highcharts({
						chart: {
							type: 'pie',
							options3d: {
								enabled: true,
								alpha: 45
							}
						},
						title: {
							text: 'Sentiment Analysis'
						},
						subtitle: {
							text: 'Sentiment'
						},
						plotOptions: {
							pie: {
								innerSize: 100,
								depth: 45
							}
						},
						series: [{
							name: 'Total number',
							data: [
								['positive sentiments', raw_data.positive_count/(raw_data.positive_count+raw_data.negative_count+raw_data.neutral_count)*100],
								['negative sentiments', raw_data.negative_count/(raw_data.positive_count+raw_data.negative_count+raw_data.neutral_count)*100],
								['neutral sentiments', raw_data.neutral_count/(raw_data.positive_count+raw_data.negative_count+raw_data.neutral_count)*100],
							]
						}]
					});
				});
			}
		};
	})();

	document.addEventListener('svg-loaded', function(e) {
		var zoom = d3.behavior.zoom()
			.scaleExtent([0.02, 2]);

		var svg = d3.select('#visualization > svg')
			.call(zoom);

		var g = d3.select('#visualization > svg > g');

		zoom.on('zoom', function() {
			g.attr('transform',
				'translate('+d3.event.translate+') scale('+d3.event.scale+')'
			);
		});

		$('[data-toggle="popover"]').popover()
	});

	if ($('#visualization > svg').length == 0) {
		$('#processing-modal').modal('show');

		document.addEventListener('csv-data-loaded', function(e) {
			console.log(e.detail)
			VisualizationHandler.plotDonut(e.detail);

			$('#processing-modal').modal('hide');
		});

		setTimeout(function() { DataParser.load(); }, 1500);
	} else { document.dispatchEvent(svg_event); }
})();