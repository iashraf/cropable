$(function() {

	var __style, __class, __width;

	function fieldName(field) {
		return '#' + __class + '_' + __style + '_' + field;
	};

	function updateCrop(coords) {
		var $self = $(this);

		$(fieldName('x')).val(coords.x);
		$(fieldName('y')).val(coords.y);
		$(fieldName('w')).val(coords.w);
		$(fieldName('h')).val(coords.h);
	};

	function imageLoad($self) {
		var ih = $self.height(),
			iw = $self.width(),
			diff = __width / iw;

		console.log(diff);

		var aspect = Number($self.data('aspect')),
			x = Number($self.data('x')) / diff,
			y = Number($self.data('y')) / diff,
			h = Number($self.data('h')) / diff,
			w = Number($self.data('w')) / diff,
			opts = {
				onChange: function() { updateCrop.apply($self, arguments); },
				onSelect: function() { updateCrop.apply($self, arguments); }
			};

		if (aspect) {
			opts.aspectRatio = aspect;
		}

		if ($self.data('x') != null) {
			opts.setSelect = [
				x,
				y,
				x + w,
				y + h
			];
		}
		else {
			var ix, iy,
				iAspect = iw / ih;

			if (aspect > iAspect) { // Wide
				ix = 0;
				iy = ( ih - ( iw / aspect ) ) / 2;
			}
			else if (aspect < iAspect) { // Tall
				ix = ( iw - ( ih * aspect ) ) / 2;
				iy = 0;
			}
			else {
				ix = 0;
				iy = 0;
			}


			opts.setSelect = [
				ix,
				iy,
				iw,
				ih
			];
		console.log(opts, iAspect);
		}

		$('.crop-container #h').val(ih);
		$('.crop-container #w').val(iw);

		$self
			.Jcrop(opts);
	};

	function cropify(container) {
		__style = $('.crop-container').data('style');
		__class = $('.crop-container').data('class');
		__width = $('.crop-container').data('width');

		container = container || 'body';

		$(container)
			.find('.crop')
				.each(function() {
					var $self = $(this),
						src = $self.attr('src'),
						img = new Image();

					img.onload = function() {
						imageLoad($self);
					};

					img.src = src;
				});
	};

	$(document)
		.on('cbox_complete', function() {
			cropify('#cboxLoadedContent');
		});

	cropify();

});