(function() {
	"use strict";

	var svg_event = new CustomEvent('svg-loaded');

	var DataParser = (function() {
		return {
			load: function() {

				var data = d3.csv('word.csv');

				data.row(function(d) {
					return {
						word: d.word,
						count: parseInt(d.count)
					};
				}).get(function(error, data_rows) {
					var csv_event = new CustomEvent('csv-data-loaded', {detail: data_rows});

					document.dispatchEvent(csv_event);
				});
			}
		};
	})();

	var VisualizationHandler = (function () {
		return {
			plotWordCloud: function(raw_data) {
					var plot = function(num_words) {
						num_words = num_words || 80;

						if (raw_data.length < num_words)
							num_words = raw_data.length;

						function getMinCount(data) {
							var min = Number.MAX_VALUE;

							for (var i = 0; i < data.length; i++) {
								min = Math.min(min, data[i].count);
							}

							return min;
						}

						function getMaxCount(data) {
							var max = 0;

							for (var i = 0; i < data.length; i++) {
								max = Math.max(max, data[i].count);
							}

							return max;
						}

						var WordCloudData = [];

						var min_val = getMinCount(raw_data),
							max_val = getMaxCount(raw_data);

						var sizes = d3.scale.linear()
							.domain([min_val, max_val])
							.range([(min_val == max_val ? 30 : 15), 75]);

						for (var i = 0; i < raw_data.length; i++) {
							WordCloudData.push({
								text: raw_data[i].word,
								size: sizes(raw_data[i].count)
							});
						}

						WordCloudData.sort(function(a, b) { return (b.size - a.size); });

						WordCloudData = WordCloudData.splice(0, num_words);

						var fill = d3.scale.category20();

						d3.layout.cloud().size([900, 450])
						.words(WordCloudData)
						.padding(5)
						.rotate(0)
						.font('Impact')
						.fontSize(function(d) { return d.size; })
						.on('end', draw)
						.start();


						function draw(words) {
							$('#visualization').html('');

							d3.select('#visualization').append('svg')
								.attr('width', 900)
								.attr('height', 450)
								.append('g')
								.attr('transform', 'translate(450,225)')
								.selectAll('text')
								.data(words)
								.enter().append('text')
								.style('font-size', function(d) { return d.size + 'px'; })
								.style('font-family', 'Impact')
								.style('fill', function(d, i) { return fill(i); })
								.attr('text-anchor', 'middle')
								.attr('transform', function(d) {
									return 'translate(' + [d.x, d.y] + ')rotate(' + d.rotate + ')';
								})
								.text(function(d) { return d.text; });
						}
					}

					plot(80)

					
			}
		};
	})();

	

	if ($('#visualization > svg').length == 0) {
		$('#processing-modal').modal('show');

		document.addEventListener('csv-data-loaded', function(e) {
			VisualizationHandler.plotWordCloud(e.detail);

			$('#processing-modal').modal('hide');
		});

		setTimeout(function() { DataParser.load(); }, 1500);
	} else { document.dispatchEvent(svg_event); }
})();