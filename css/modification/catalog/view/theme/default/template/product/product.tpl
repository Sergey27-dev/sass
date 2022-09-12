<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="row">
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-8'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <?php if ($thumb || $images) { ?>
          <ul class="thumbnails">
            <?php if ($thumb) { ?>
            <li><a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>" /></a></li>
            <?php } ?>
            <?php if ($images) { ?>
            <?php foreach ($images as $image) { ?>
            <li class="image-additional"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>" /></a></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>

			<?php if ($question_status) { ?>
            <li id="product-question"><a href="#tab-questions" data-toggle="tab"><?php echo $tab_questions; ?> (<?php echo $questions_total; ?>)</a></li>
            <?php } ?>
			
            <?php if ($attribute_groups) { ?>
            <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
            <?php } ?>
            <?php if ($review_status) { ?>
            <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
            <?php } ?>
          </ul>
          <div class="tab-content">

			<?php if ($question_status) { ?>
          	<div class="tab-pane" id="tab-questions">
          	<?php echo $product_questions; ?>
			</div>
          	<?php } ?>
			
            <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
            <?php if ($attribute_groups) { ?>
            <div class="tab-pane" id="tab-specification">
              <table class="table table-bordered">
                <?php foreach ($attribute_groups as $attribute_group) { ?>
                <thead>
                  <tr>
                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                  <tr>
                    <td><?php echo $attribute['name']; ?></td>
                    <td><?php echo $attribute['text']; ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
            <?php if ($review_status) { ?>
            <div class="tab-pane" id="tab-review">
              <form class="form-horizontal" id="form-review">
                <div id="review"></div>
                <h2><?php echo $text_write; ?></h2>
                <?php if ($review_guest) { ?>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                    <input type="text" name="name" value="" id="input-name" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                    <div class="help-block"><?php echo $text_note; ?></div>
                  </div>
                </div>
                <div class="form-group required">
                  <div class="col-sm-12">
                    <label class="control-label"><?php echo $entry_rating; ?></label>
                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                    <input type="radio" name="rating" value="1" />
                    &nbsp;
                    <input type="radio" name="rating" value="2" />
                    &nbsp;
                    <input type="radio" name="rating" value="3" />
                    &nbsp;
                    <input type="radio" name="rating" value="4" />
                    &nbsp;
                    <input type="radio" name="rating" value="5" />
                    &nbsp;<?php echo $entry_good; ?></div>
                </div>
                <?php if ($site_key) { ?>
                  <div class="form-group">
                    <div class="col-sm-12">
                      <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
                    </div>
                  </div>
                <?php } ?>
                <div class="buttons clearfix">
                  <div class="pull-right">
                    <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                  </div>
                </div>
                <?php } else { ?>
                <?php echo $text_login; ?>
                <?php } ?>
              </form>
            </div>
            <?php } ?>
          </div>
        </div>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-4'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <div class="btn-group">
            <button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button>
            <button type="button" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button>
          </div>
          <h1><?php echo $heading_title; ?></h1>
          <ul class="list-unstyled">
            <?php if ($manufacturer) { ?>
            <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
            <?php } ?>
            <li><?php echo $text_model; ?> <?php echo $model; ?></li>
            <?php if ($reward) { ?>
            <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
            <?php } ?>
            <li><?php echo $text_stock; ?> <?php echo $stock; ?></li>
          </ul>
          <?php if ($price) { ?>
          <ul class="list-unstyled">
            <?php if (!$special) { ?>
            <li>
              <h2><?php echo $price; ?></h2>
            </li>
            <?php } else { ?>
            <li><span style="text-decoration: line-through;"><?php echo $price; ?></span></li>
            <li>
              <h2><?php echo $special; ?></h2>
            </li>
            <?php } ?>
            <?php if ($tax) { ?>
            <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
            <?php } ?>
            <?php if ($points) { ?>
            <li><?php echo $text_points; ?> <?php echo $points; ?></li>
            <?php } ?>
            <?php if ($discounts) { ?>
            <li>
              <hr>
            </li>
            <?php foreach ($discounts as $discount) { ?>
            <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
            <?php } ?>
            <?php } ?>
          </ul>
          <?php } ?>
          <div id="product">
            <?php if ($options) { ?>
            <hr>
            <h3><?php echo $text_option; ?></h3>
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="checkbox">
                  <label>
                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                <div class="radio">
                  <label>
                    <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                    <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                  </label>
                </div>
                <?php } ?>
              </div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php if ($recurrings) { ?>
            <hr>
            <h3><?php echo $text_payment_recurring ?></h3>
            <div class="form-group required">
              <select name="recurring_id" class="form-control">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($recurrings as $recurring) { ?>
                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
            </div>
            <?php } ?>
            <div class="form-group">
              <label class="control-label" for="input-quantity"><?php echo $entry_qty; ?></label>
              <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
              <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              <br />
              <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block"><?php echo $button_cart; ?></button>
            </div>
            <?php if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
            <?php } ?>
          </div>
          <?php if ($review_status) { ?>
          <div class="rating">
            <p>
              <?php for ($i = 1; $i <= 5; $i++) { ?>
              <?php if ($rating < $i) { ?>
              <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } else { ?>
              <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
              <?php } ?>
              <?php } ?>
              <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $text_write; ?></a></p>
            <hr>
            <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script>
            <!-- AddThis Button END -->
          </div>
          <?php } ?>
        </div>
      </div>
      <?php if ($products) { ?>
      <h3><?php echo $text_related; ?></h3>
      <div class="row">
        <?php $i = 0; ?>
        <?php foreach ($products as $product) { ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
        <?php } else { ?>
        <?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
        <?php } ?>
        <div class="<?php echo $class; ?>">
          <div class="product-thumb transition">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div class="caption">
              <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
              <p><?php echo $product['description']; ?></p>
              <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
              <?php if ($product['price']) { ?>
              <p class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                <?php } ?>
                <?php if ($product['tax']) { ?>
                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                <?php } ?>
              </p>
              <?php } ?>
            </div>
            <div class="button-group">
              <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="fa fa-shopping-cart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
              <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
            </div>
          </div>
        </div>
        <?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
        <div class="clearfix visible-md visible-sm"></div>
        <?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
        <div class="clearfix visible-md"></div>
        <?php } elseif ($i % 4 == 0) { ?>
        <div class="clearfix visible-md"></div>
        <?php } ?>
        <?php $i++; ?>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($tags) { ?>
      <p><?php echo $text_tags; ?>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </p>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
	$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#recurring-description').html('');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();

			if (json['success']) {
				$('#recurring-description').html(json['success']);
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-cart').button('loading');
		},
		complete: function() {
			$('#button-cart').button('reset');
		},
		success: function(json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = $('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				$('#cart > button').html('<i class="fa fa-shopping-cart"></i> ' + json['total']);

				$('html, body').animate({ scrollTop: 0 }, 'slow');

				$('#cart > ul').load('index.php?route=common/cart/info ul li');
			}
		}
	});
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	if (typeof timer != 'undefined') {
    	clearInterval(timer);
	}

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);

			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.text-danger').remove();

					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}

					if (json['success']) {
						alert(json['success']);

						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
});

$(document).ready(function() {
	$('.thumbnails').magnificPopup({
		type:'image',
		delegate: 'a',
		gallery: {
			enabled:true
		}
	});
});
//--></script>

			<?php // << Live Price ?>
			<?php if (isset($liveprice_installed) && $liveprice_installed) { ?>

			<script type="text/javascript">
				
				
				function liveprice_anim_block(fadeTo) {
					
					<?php if ( isset($liveprice_settings['animation']) && $liveprice_settings['animation'] ) { ?>
				
						var blocks_to_anim = [];
						<?php if ( $lp_theme_name == 'default' ) { ?>
							// default theme
							var lp_infos = $('#product').parent().find('.list-unstyled');
							if (lp_infos.length >= 2 ) {
								blocks_to_anim.push( $(lp_infos[1]) );
							}
						<?php } elseif ( $lp_theme_name == 'pav_brave' ) { ?>
							var price_block = $('.product-info .product-info-bg .price');
							if ( price_block.length ) {
								blocks_to_anim.push( price_block );
								if ( price_block.next().is('ul.list-unstyled') ) {
									blocks_to_anim.push( price_block.next() );
								}
							}
						<?php } elseif ( $lp_theme_name == 'stowear' ) { ?>
							blocks_to_anim.push( $('#quickview_product .price') );
						<?php } elseif ( $lp_theme_name == 'mediacenter' ) { ?>
							blocks_to_anim.push( $('#quickview_product .price') );
						<?php } elseif ( $lp_theme_name == 'royal' ) { ?>
							blocks_to_anim.push( $('.line-product') );	
						<?php } ?>
						
						if ( blocks_to_anim.length ) {
							for ( var i_blocks_to_anim in blocks_to_anim ) {
								if ( blocks_to_anim.hasOwnProperty(i_blocks_to_anim) )
								var block_to_anim = blocks_to_anim[i_blocks_to_anim];
								block_to_anim.fadeTo('fast', fadeTo);
							}
						}
					<?php } ?>
				
				}
				
				<?php
					if ( isset($lp_non_standard_theme) ) {
						echo "var lp_non_standard_theme = '".$lp_non_standard_theme."';";
					}
				?>
				var liveprice_last_request = 0;
				var liveprice_recalc_timer = 0;
				
				function liveprice_recalc(liveprice_delay) {
				
					clearTimeout(liveprice_recalc_timer);
					if ( liveprice_delay ) {
						liveprice_recalc_timer = setTimeout(function(){
							liveprice_recalc();
						}, liveprice_delay);
						return;
					}
					
					liveprice_last_request = (new Date()).getTime();
	
					if ( lp_theme_name == 'BurnEngine_shoppica' ) {
						var request_url = 'index.php?route=product/product&get_liveprice=1';
					} else {
						var request_url = 'index.php?route=module/liveprice/get_price';
					}
					<?php if ( $lp_theme_name=='themeXXX' && empty($product_id) && !empty($product['product_id']) ) { ?>
						request_url += '&product_id=<?php echo $product['product_id']; ?>';
					<?php } else { ?>
						request_url += '&product_id=<?php echo $product_id; ?>';
					<?php } ?>
					request_url += '&quantity='+$('input#input-quantity, input#qty-input, input#qty[name="quantity"], #product input[name="quantity"], .ajax-quickview-cont .quantity [name="quantity"], #quantity_wanted, select#quantity, .product-info .cart input[name=quantity], .product-info .pokupka input[name=quantity], #popup-order-okno input[name=quantity], #quantity-set').val();
					request_url += '&rnd='+liveprice_last_request;
					if ( typeof(lp_non_standard_theme) != 'undefined' && lp_non_standard_theme ) {
						request_url += '&non_standard_theme='+lp_non_standard_theme;
					}
					
					var elem_with_options = $(document);
					if ( lp_theme_name == 'theme622' ) {
						elem_with_options = $('#product');
					}
					if ( lp_theme_name == 'revolution' ) {
						if ( $('#popup-view-wrapper').length ) { // quickview
							elem_with_options = $('#popup-view-wrapper');
						} else if ( $('#popup-order-okno').length ) { // quickorder
							elem_with_options = $('#popup-order-okno');
						}
					}
					options_data = elem_with_options.find('select[name^="'+lp_option_prefix+'["], input[name^="'+lp_option_prefix+'["][type=\'radio\']:checked, input[name^="'+lp_option_prefix+'["][type=\'checkbox\']:checked, textarea[name^="'+lp_option_prefix+'["], input[name^="'+lp_option_prefix+'["][type="text"], [name^="quantity_per_option["]');
					
					$.ajax({
						type: 'POST',
						url: request_url,
						data: options_data,
						dataType: 'json',
						beforeSend: function() {
							liveprice_anim_block(0.1);
						},
						complete: function() {},
						success: function(json) {
							//console.debug(json);
							
							if (json && json.rnd && json.rnd == liveprice_last_request) {
								
								if ( typeof(lp_non_standard_theme) != 'undefined' && lp_non_standard_theme == 'mstore' ) {
								
									$('#lp_price').html(json.htmls.html);
									
								} else if ( typeof(lp_non_standard_theme) != 'undefined' && lp_non_standard_theme == 'FntProductDesign') {
									
									if ( $('#product .price').next().is('.price-tax') ) {
										$('#product .price').next().remove();
									}
									if ( $('#product .price').next().is('ul.list-unstyled') ) {
										$('#product .price').next().remove();
									}
									$('#product .price').replaceWith(json.htmls.html);		
							
								} else if (json.ct == 'monster') {
									$('#product div.priceArea p.newprice').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'smarti' || json.ct == 'beamstore') {
									$('.product-info .price').html(json.htmls.html);
									
								} else if (json.ct == 'smarti' || json.ct == 'beamstore') {
									$('.product-info .price').html(json.htmls.html);	
									
								} else if (json.ct == 'themegloballite') {
									$('.product-info .price').html(json.htmls.html);
									
								} else if (json.ct == 'pav_digitalstore') {
									$('.product-info .price').html(json.htmls.html);
									
								} else if (json.ct == 'megashop') {
									$('.product-info .price').html(json.htmls.html);
									
								} else if (json.ct == 'bigshop') {
									$('.product-info ul.price-box').html(json.htmls.html);	
									
								} else if (json.ct == 'pav_fashion') {
									$('.product-info .price ul.list-unstyled:first').replaceWith(json.htmls.html1);
									$('.product-info ul.description').html(json.htmls.html2);
									
								} else if (json.ct == 'pav_dress_store') {
									$('.product-info .price ul.list-unstyled:first').html(json.htmls.html);	
									
								} else if (json.ct == 'theme500') {
									
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme516') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme519') { // Beauty
									$('.product-info .price-section').html(json.htmls.html); 	
									
								} else if (json.ct == 'theme531') {
									$('.product-info .price-section').html(json.htmls.html);
								
								} else if (json.ct == 'theme533') {
									$('.product-info .price-section').html(json.htmls.html);
								
								} else if (json.ct == 'theme560') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme649') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme622') {
									$('.product-info .price-section').html(json.htmls.html);	
									
								} else if (json.ct == 'theme511') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme546') {
									$('#product .price-section').html(json.htmls.html);		
									
								} else if (json.ct == 'cosyone') {
									
									if ( $('span[itemprop=offerDetails] .extended_offer').next().is('div.contrast_font').length ) {
										$('span[itemprop=offerDetails] .extended_offer').next().remove();
									}
									if ( $('span[itemprop=offerDetails] .extended_offer').next().is('div.hurry').length ) {
										$('span[itemprop=offerDetails] .extended_offer').next().remove();
									}
									
									if ( $('span[itemprop=offerDetails] .extended_offer').length ) {
										$('span[itemprop=offerDetails] .extended_offer').remove();
										$('span[itemprop=offerDetails]').prepend(json.htmls.html);
									}
									$('.product-info .extended_offer').replaceWith(json.htmls.html);
								
									$('#product .cart .price').html(json.htmls.html1);
									$('#product').find('.minimum, .reward, .discount').remove();
									$('#product .cart').after(json.htmls.html2);	
									
								} else if (json.ct == 'OPC080182') {
									$('#product').siblings('.list-unstyled').html(json.htmls.html);
									
								} else if (json.ct == 'OPC080183') {
									$('#product').siblings('.prod-price').find('li:first').replaceWith(json.htmls.html1);
									$('#product').siblings('.prod-price').next().replaceWith(json.htmls.html2);
									
								} else if (json.ct == 'OPC080191') {
									$('#product').siblings('.list-unstyled:first').html(json.htmls.html);
									
								} else if (json.ct == 'sellegance') {
									
									var stock_info = $('#content .price .stock').html();
									$('#content .price').html(json.htmls.html.replace('%stock%', stock_info));
								
									//var stock_info = $('.product-info .price .stock').html();
									//$('.product-info .price').html(json.htmls.html.replace('%stock%', stock_info));
									
								} else if (json.ct == 'glade') {
									$('#product .price').html(json.htmls.html);
									
								} else if (json.ct == 'lamby') {
									$('.product-shop .list-unstyled.price-box').html(json.htmls.html);
									
								} else if (json.ct == 'journal2') {
									$('#product .list-unstyled.price:first').html(json.htmls.html);
								
								} else if (json.ct == 'fortuna') {
									$('#product div.price').replaceWith(json.htmls.html);	
								
								} else if (json.ct == 'rgen-opencart') {
									$('#content .product-info .buying-info .price-wrp').html(json.htmls.html);
									$('#content .product-info .buying-info1').html(json.htmls.html1);
									
								} else if (json.ct == 'bt_comohos') {
									$('.product-info .price_info').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'bt_superexpress') {
									$('.product-info .price_info').html(json.htmls.html);	
									
								} else if (json.ct == 'bt_gameworld') {
									$('#product .cart .price_info').replaceWith(json.htmls.html);	
									
								} else if (json.ct == 'amazecart') {
									$('#product').parent().find('div.prdmf').each(function() {
										if ( $(this).find('.list-unstyled').length == 2 ) {
											$($(this).find('.list-unstyled')[1]).replaceWith(json.htmls.html);		
										} else if ( $(this).find('.list-unstyled').length == 1 ) {
											$($(this).find('.list-unstyled')[0]).replaceWith(json.htmls.html);		
										}
									})
									
								} else if (json.ct == 'ntl' || json.ct == 'bt_claudine') { 
									$('.product-info .price_info').replaceWith(json.htmls.html);
									
								} else if (json.ct.substring(0,6) == 'carera' ) { 
									$('.price-box').html(json.htmls.html);	
									
								} else if (json.ct == 'allure') { 
									$('#product ul.list-unstyled[itemprop="offerDetails"]').html(json.htmls.html);	
									
								} else if (json.ct.substring(0,10) == 'OPC080185_') { // Glorious	
									$('#product').siblings('.list-unstyled:first').replaceWith(json.htmls.html);
									
								} else if (json.ct.substring(0,10) == 'OPC080188_') { // Arise	
									$('#product').siblings('.list-unstyled:first').replaceWith(json.htmls.html);	
									
								} else if (json.ct == 'kingstorepro') {
									$('#product').parent().find('div.price').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'fastor') {
									var countdown = $('#quickview_product').find('div.price').find('[id^="countdown"]');
									if ( countdown.length ) {
										countdown.detach();
									}
									$('#quickview_product').find('div.price').html(json.htmls.html);
									if ( countdown.length ) {
										var countdown = $('#quickview_product').find('div.price').find('[id^="countdown"]').replaceWith(countdown);
									}
									
								} else if (json.ct == 'coloring') {
									$('#product div.price').html(json.htmls.html);
									
								} else if (json.ct == 'OPC080178') {
									$('div.price ul').html(json.htmls.html);
									
								} else if (json.ct == 'vitalia') {
									$('#quickview_product div.price').html(json.htmls.html);	
									
								} else if (json.ct == 'tt_petsyshop') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct == 'tt_erida') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct.substring(0,8) == 'tt_andro') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct.substring(0,13) == 'tt_cendo_home') {
									$('#product').siblings('div.price:first').html(json.htmls.html);	
									
								} else if (json.ct.substring(0,9) == 'tt_veneno') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
								
								} else if (json.ct.substring(0,8) == 'tt_rossi') {
									$('#product').siblings('div.price:first').html(json.htmls.html);		
									
								} else if (json.ct == 'coolbaby') {
									$('div.product_page_price').html(json.htmls.html);
									
								} else if (json.ct == 'bt_parallax') {
									$('#product .boss-price').html(json.htmls.html);
									
								} else if (json.ct == 'shopme') {
									$('.product-info .price').html(json.htmls.html);
									$('.product-info .price-tax').replaceWith(json.htmls.html1);
									$('.product-info .minimum').remove();
									$('.product-info .reward').remove();
									$('.product-info .discount').replaceWith(json.htmls.html2);
									
								} else if (json.ct == 'pav_beeshop') {
									$('#product').parent().find('div.price.detail').next('ul').remove();
									$('#product').parent().find('div.price.detail').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'stowear') {
									$('#quickview_product .price').html(json.htmls.html);
									
								} else if (json.ct == 'mediacenter') {
									$('#quickview_product .price').html(json.htmls.html);
								
								} else if (json.ct == 'newstore') {
									$('#product .price').html(json.htmls.html);	
									
								} else if (json.ct == 'OPCADD003') {
									var price_el = $('#product').siblings('ul.prod-price').find('h3:first');
									if ( price_el.prev().is('span') ) {
										price_el.prev().remove();
									}
									price_el.replaceWith(json.htmls.html1);
									
									if ( $('#product').siblings('ul').length > 1 ) {
										$($('#product').siblings('ul')[1]).html(json.htmls.html2);
									}
									
								} else if (json.ct == 'tt_optima_kids') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct.substring(0,17) == 'tt_greentech_home') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct == 'sstore') {
									$('.product-info .price').replaceWith(json.htmls.html);
									
								} else if (json.ct.substr(0,14) == 'so-shoppystore') {
									$('#product').parent().find('.product_page_price').html(json.htmls.html);
									
								} else if (json.ct == 'logancee') {
									$('#product').parent().find('.price').html(json.htmls.html);
									
								} else if (json.ct == 'welldone') {
									$('.product-info .product-info__price').html(json.htmls.html);
									
								} else if (json.ct == 'theme637') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme628') { // Basky
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct.substring(0,10) == 'tt_sagitta') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct == 'unishop') {
									$('#product ul.list-unstyled:first').find('li:first').replaceWith(json.htmls.html1);
									$('#product ul.list-unstyled:first').find('li.discount').replaceWith(json.htmls.html2);
									
								} else if (json.ct.substring(0,9) == 'tt_bstore') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct == 'pav_styleshop') {
									$('.product-info .price').html(json.htmls.html);
									
								} else if (json.ct.substring(0,9) == 'tt_selphy') {
									$('#product').siblings('div.product-price').html(json.htmls.html);
									
								} else if (json.ct.substring(0,8) == 'tt_orion') {
									$('#product').siblings('div.price').html(json.htmls.html);
									
								} else if (json.ct == 'theme643') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct.substring(0,6) == 'aspire') {
									if ( $('.product-view .price-block').next().is('ul.list-unstyled') ) {
										$('.product-view .price-block').next().remove();
										$('.product-view .price-block').replaceWith(json.htmls.html);	
									}
								
								} else if (json.ct.substring(0,14) == 'tt_lavoro_home') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									
								} else if (json.ct == 'moneymaker2') { // moneymaker2
									$('#product .price-detached').html(json.htmls.html);
									
								} else if (json.ct == 'julytheme') { // July
									$('.product-info ul.list-unstyled:first').html(json.htmls.html);
									
								} else if (json.ct == 'megastore') {	
									$('#content #product').siblings('.list-unstyled:first').html(json.htmls.html);	
									
								} else if (json.ct == 'onstore') { // ONStore
									$('.product-info .price-box.price').html(json.htmls.html);
									
								} else if (json.ct == 'julytheme') { // July
									$('.product-info .price').html(json.htmls.html);
									
								} else if (json.ct == 'sebian') { // 
									$('#product').parent().find('.list-unstyled:first').html(json.htmls.html);
									
								} else if (json.ct == 'bt_tool') { // Furniture, Tool & Hardware	
									$('.product-info .price_info').html(json.htmls.html);
									
								} else if (json.ct == 'OPCADD007' || json.ct == 'ahturf-whs' ) { // Mega Store (ahturf-whs - custom rename)
									$('#product').parent().find('.list-unstyled:first').html(json.htmls.html);
									
								} else if (json.ct.substring(0,14) == 'tt_matalo_home') {
									$('#product').siblings('div.price:first').html(json.htmls.html);
									if ( $('#product').siblings('.list-unstyled').length > 1 && json.htmls.html2 ) {
										$('#product').siblings('.list-unstyled:first').html(json.htmls.html2);
									}
								
								} else if (json.ct == 'boxed') {	
									
									var lp_infos = $('#product').parent().find('.list-unstyled');
									if (lp_infos.length >= 2 ) {
										$(lp_infos[1]).html(json.htmls.html);
									}
								
								} else if (json.ct == 'zorka') {
									$('.product-info .product-price').html(json.htmls.html);
									
								} else if (json.ct == 'pav_shopping_office') {	
									
									$('#product').siblings('.price.detail').remove();
									$('#product').siblings('.list-unstyled:first').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'BurnEngine_technopolis') {
									$('.main .price').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'BurnEngine_shoppica') {
									$('.main .price-tax').remove();
									$('.main .reward').remove();
									$('.main .price-savings').remove();
									//$('.main .price').remove();
									$('.main .price').replaceWith(json.htmls.html);
									
								} else if (json.ct.substring(0,9) == 'OPC080187') { // Arise	
									$('#product').siblings('.list-unstyled:first').html(json.htmls.html);	
									
								} else if (json.ct == 'marketshop') {
									$('.product-info .price-box').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'hosoren') {
									while ( $('.product-features .product_list-actions').next().is('p') ) {
										$('.product-features .product_list-actions').next().remove();
									}
									$('.product-features .product_list-actions').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'tt_sonic') {
									$('.product-price').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'pav_clickshop') {
								
									// tax
									if ( $('.price').next().is('ul.list-unstyled') && !$('.price').next().find('span.check-box').length ) {
										$('.price').next().remove();
									}
									//discounts
									if ( $('.price').next().is('ul.list-unstyled') && !$('.price').next().find('span.check-box').length ) {
										$('.price').next().remove();
									}
									$('.price').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'revolution') {

									if ( $('#popup-view-wrapper').length ) { // quickview
										$('.product-info .update_price').replaceWith(json.htmls.html);
										$('.product-info .update_special').replaceWith(json.htmls.html1);
										$('.product-info .discounts').replaceWith(json.htmls.html_d);
									} else if ( $('#popup-order-okno').length ) { // quickorder
										$('#popup-order-okno .totals').replaceWith(json.htmls.html3);
										$('#popup-order-okno .discounts').replaceWith(json.htmls.html_d);
									} else { // product page
										$('.product-info div[itemprop="offers"] .update_price').replaceWith(json.htmls.html);
										$('.product-info div[itemprop="offers"] .update_special').replaceWith(json.htmls.html1);
										$('.product-info div[itemprop="offers"] [itemprop="price"]').replaceWith(json.htmls.html2);
										$('.product-info div[itemprop="offers"]').parent().siblings('.discounts').replaceWith(json.htmls.html_d);
									}
									
								} else if ( json.ct == 'pav_brave' ) {
									var price_block = $('.product-info .product-info-bg .price');
									if ( price_block.length ) {
										price_block.html(json.htmls.html);
										if ( price_block.next().is('ul.list-unstyled') ) {
											price_block.next().html(json.htmls.html1);
										}
									}
									
								} else if ( json.ct == 'yourstore' ) {	
									
									$('#product').siblings('.discount').remove();
									
									var price_elem = $('#product').siblings('.price-box');
									if ( price_elem.nextAll('span.reward').length ) {
									
										var contents = price_elem.parent().contents(); // including text elements
										var removing_is_started = false;
										for (var i_contents=0; i_contents<contents.length; i_contents++ ) {
											var current_elem = $(contents[i_contents]);
											if ( removing_is_started ) {
												if ( current_elem.is('span.reward') ) {
													current_elem.remove();
													break;
												} else {
													current_elem.remove();
												}
											} else if ( current_elem.is('.price-box') ) {
												removing_is_started = true;
											}
										}
										/*
										while ( price_elem.next().length && !price_elem.next().is('span.reward') ) {
											price_elem.next().remove();
										}
										*/
										price_elem.next().remove();
									}
									price_elem.replaceWith(json.htmls.html);
								
								} else if ( json.ct == 'themeXXX' ) {		
									
									var price_elem = $('.ajax-quickview .price');
									if ( price_elem.length ) { // quickview
										price_elem.replaceWith(json.htmls.html1);
									} else {
										price_elem = $('#product .price-section');
										if ( price_elem.next().is('.product-countdown') ) {
											price_elem.next().remove();
										}
										price_elem.replaceWith(json.htmls.html);
									}
									
								} else if (json.ct == 'diceylook') {
									$('#quickview_product .price').html(json.htmls.html);
									
								} else if (json.ct == 'tt_oxelar') {
									var price_elem = $('#product').siblings('.price-product');
									if ( price_elem.length ) {
										if ( price_elem.next().is('ul.list-unstyled') && price_elem.next().next().is('ul.list-unstyled') && price_elem.next().next().next().is('p.short-des') ) {
											price_elem.next().remove();
										}
										price_elem.replaceWith(json.htmls.html);
									}
									
								} else if (json.ct == 'goshop') {
								
									$('#product').parent().find('.price').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'theme583') { // Popcorn Online Store
									$('.product-info .price-section').html(json.htmls.html);		
									
								} else if (json.ct == 'so-furnicom') {	
									$('.product_page_price').replaceWith(json.htmls.html);
									
								} else if (json.ct == 'royal') { // Royal
									if ( $('.line-product').next().is('.list-unstyled') ) {
										$('.line-product').next().remove(); // discounts
									}
									$('.line-product').html(json.htmls.html);
									$('.line-product').after(json.htmls.html1);
										
								} else if (json.ct == 'theme506') {
									$('.product-info .price-section').html(json.htmls.html);
									
								} else if (json.ct == 'theme707') {
									$('.product-info .price-section').html(json.htmls.html);	
									
								}	else {
								
									var lp_infos = $('#product').parent().find('.list-unstyled');
									if (lp_infos.length >= 2 ) {
										$(lp_infos[1]).html(json.htmls.html);
										//$(lp_infos[1]).replaceWith(json.htmls.html);
									} else if ( lp_infos.length == 1 ) {
										lp_infos.html(json.htmls.html);
									}
								}
								
								liveprice_anim_block(1);
							}
						},
						error: function(error) {
							console.log(error);
						}
					});
					
				}
				
				var lp_theme_name = '<?php echo isset($lp_theme_name) ? $lp_theme_name : ''; ?>';
					
				var lp_option_prefix = "option";
				
				//$(document).ready( function() {
				var liveprice_init_timer_id = 0;
				function liveprice_init(ready_state_complete_required, call_for_no_options) {
				
					clearTimeout(liveprice_init_timer_id);
					if ( typeof($) == 'undefined' || ( ready_state_complete_required && document.readyState != 'complete' )  ) {
						liveprice_init_timer_id = setTimeout(function(){
							// if there wasn't jQuery from the start, we should wait for document.readyState == 'complete'
							liveprice_init(true);
						}, 50);
						return;
					}
					
					// for some themes. options may be not available on this stage, so lets call for init on document.ready
					if ( !call_for_no_options ) {
						if ( !$('input[name^="'+lp_option_prefix+'["],select[name^="'+lp_option_prefix+'["],textarea[name^="'+lp_option_prefix+'["]').length ) {
							$(document).ready(function(){
								liveprice_init(ready_state_complete_required, true);
							});
							return;
						}
					}
					
					if ($('#mijoshop').length && $('[name^="option_oc["]').length) { // 
						lp_option_prefix = "option_oc";
					}
				
					$('select[name^="'+lp_option_prefix+'["]').on('change', function(){
						liveprice_recalc(10);
					});
					
					$('input[name^="'+lp_option_prefix+'["]').on('change', function(){
						liveprice_recalc(10);
					});
					
					$('textarea[name^="'+lp_option_prefix+'["]').on('change', function(){
						liveprice_recalc(10);
					});
					
					$('#input-quantity, #qty-input, input#qty[name="quantity"], #product input[name="quantity"], .ajax-quickview-cont .quantity [name="quantity"], #quantity_wanted, select#quantity, .product-info .cart input[name=quantity], .product-info .pokupka input[name=quantity], #quantity-set').on('input propertychange change paste', function(){
						liveprice_recalc(10);
					});
					
					if ( $('select#quantity').length ) {
						$('select#quantity').change();
					}
					
					// Product Size Option
					// replace function
					var fix_updatePriceBySize = function(){
						if ( typeof(updatePriceBySize) == 'function') {
							updatePriceBySize = function(){
								liveprice_recalc(100);
							};
							liveprice_recalc(100);
						}
					}
					if ( typeof(updatePriceBySize) == 'function' ) {
						fix_updatePriceBySize();
					} else {
						$(document).load( fix_updatePriceBySize );
					}
					
					// << compatibility Option Price by Char Pro
					if ($('input[name^="'+lp_option_prefix+'["][ppc_current_price], textarea[name^="'+lp_option_prefix+'["][ppc_current_price]').length) {
						$('input[name^="'+lp_option_prefix+'["][ppc_current_price], textarea[name^="'+lp_option_prefix+'["][ppc_current_price]').on('input propertychange change paste', function(){
							liveprice_recalc(500);
						});
					}
					// >> compatibility Option Price by Char Pro
					
					
					
					<?php if ($lp_theme_name == 'journal2') { ?>
						$('#product .options ul li[data-value]').click(function(){
							liveprice_recalc(50);
						});
						$('#product .qty .journal-stepper').click(function() {
							liveprice_recalc(100);
						});
						// change theme function completely (2.9.2)
						Journal.updateProductPrice = function(){
							$.ajax({
								url: 'index.php?route=journal2/ajax/price',
								type: 'post',
								data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
								dataType: 'json',
								success: function (json) {
									// update only stock	
									$('.description .journal-stock').removeClass('outofstock').removeClass('instock').addClass(json.cls).html(json.stock);
								}
							});
						};
					<?php } ?>
					
					<?php if ($lp_theme_name == 'pav_styleshop') { ?>
						$('.productoptionslabel').click(function(){
							liveprice_recalc(50);
						});
					<?php } ?>
					
					<?php if ($lp_theme_name == 'so-furnicom') { ?>
						$('.product_quantity_up, .product_quantity_down').click(function(){
							liveprice_recalc(50);
						});
					<?php } ?>
					
					<?php if ($lp_theme_name == 'boxed') { ?>
						$(document).ready(function(){
							setTimeout(function(){
								$(document).off('click', '.spinner .btn:first-of-type');
								$(document).on('click', '.spinner .btn:first-of-type', function(){
									$('.spinner input').val(parseInt($('.spinner input').val(), 10) + 1);
									liveprice_recalc(100);
								});
								$(document).off('click', '.spinner .btn:last-of-type');
								$(document).on('click', '.spinner .btn:last-of-type', function(){
									$('.spinner input').val(Math.max(parseInt($('.spinner input').val(), 10) - 1, 1));
									liveprice_recalc(100);
								});
							}, 1);
						});
					<?php } ?>
					
					<?php if ($lp_theme_name == 'zorka') { ?>
						$('.quantity-form').on('click', '#qty-inc, #qty-dec', function(){
							liveprice_recalc(100);
						});
					<?php } ?>
					
					// quantity_list_pro compatibility
					$(document).on('mouseup', 'body #qty_list', function(){
						setTimeout(function () {
							$('#input-quantity').change();
						}, 50);
					});
					
					<?php if ($lp_theme_name == 'octheme_1012' || $lp_theme_name == 'tt_optima_kids' ) { ?>
						// octheme_1012 = Bookstore
						$('#product').on('click', '.product-quantity-button', function(){
							liveprice_recalc(10);
						});
					<?php } ?>
					
					<?php if (isset($custom_price) && $custom_price) { ?>
						$('input[name^="'+lp_option_prefix+'["]').on('propertychange input', function(){
							liveprice_recalc();
						});
					<?php } ?>
					
					// space (' ') for related options xml skipping
					$('#button-cart ') .on('click', function(){
						liveprice_recalc(500);
					});
					
					if ($('#input-quantity').length && $('#input-quantity').val() && $('#input-quantity').val() > 1) {
						liveprice_recalc();
					}
					
					if (lp_theme_name == 'shopme') {
						$('#input-quantity').siblings('.plus, .minus').click(function(){
							liveprice_recalc(10);
						});
					}
					
					if (lp_theme_name == 'mobile') {
						$(document).ready( function() {
							setTimeout( function(){
								$(document).off('click','.spinner .btn:first-of-type');
								$(document).on('click','.spinner .btn:first-of-type', function(){
									$('.spinner input').val( parseInt($('.spinner input').val(), 10) + 1);
									$('.spinner input').change();
								});
								$(document).off('click','.spinner .btn:last-of-type');
								$(document).on('click','.spinner .btn:last-of-type', function(){
									$('.spinner input').val( Math.max(parseInt($('.spinner input').val(), 10) - 1, 1));
									$('.spinner input').change();
								});
							}, 100);
						});
					}
					
					if (lp_theme_name == 'tt_petsyshop' || lp_theme_name.substring(0,8) == 'tt_andro' || lp_theme_name.substring(0,9) == 'tt_veneno'
					|| lp_theme_name.substring(0,8) == 'tt_rossi' || lp_theme_name.substring(0,9) == 'tt_selphy' || lp_theme_name.substring(0,14) == 'tt_matalo_home'
					|| lp_theme_name == 'tt_sonic' || lp_theme_name == 'tt_oxelar' ) {
						$('#input-quantity').parent().find('#plus, #minus').click(function() {
							liveprice_recalc(100);
						});
					}
					
					<?php if ( $lp_theme_name == 'royal' ) { ?>
						$('#input-quantity').closest('.form-group').find('#plus, #minus').click(function() {
							liveprice_recalc(100);
						});
					<?php } ?>
					
					if (lp_theme_name == 'coolbaby') {
						$('#product .cart .input-group-addon').click(function() {
							liveprice_recalc(100);
						});
					}
					
					if (lp_theme_name == 'maxstore') {
						$('#input-quantity').parent().find('button').click(function() {
							liveprice_recalc(100);
						});
					}
					
					//pav_digitalstore
					$('#product .quantity-adder').find('span.add-up, span.add-down').click(function() {
						liveprice_recalc(100);
					});
					
					//bt_comohos bt_gameworld bt_superexpress
					$('#input-quantity').siblings('.increase, .decrease').click(function() {
						liveprice_recalc(100);
					});
					
					// theme649 theme622
					$('#input-quantity').siblings('.counter-minus, .counter-plus').click(function() {
						liveprice_recalc(100);
					});
					
					//rgen-opencart
					$('#content .product-info .buying-info .buy-btn-wrp a.qty-handle').click(function() {
						liveprice_recalc(100);
					});
					
					//fortuna
					$('#product .qty-minus, #product .qty-plus').click(function() {
						liveprice_recalc(100);
					});
					
					//cosyone
					$('#product .cart .quantity_button').click(function() {
						liveprice_recalc(100);
					});
					
					// pav styleshop
					$('#product .quantity-adder .quantity-wrapper span').click(function() {
						liveprice_recalc(100);
					});
					
					// sellegance
					$('#product .input-qty .qty-minus, #product .input-qty .qty-plus').click(function() {
						liveprice_recalc(100);
					});
					
					
					//kingstorepro & megashop & vitalia
					$('#product #q_up, #product #q_down').click(function() {
						liveprice_recalc(100);
					});
					
					//bigshop
					$('.product-info .cart .qty .qtyBtn').click(function() {
						liveprice_recalc(100);
					});
					
					$('.product-info .cart').find('#superplus, #superminus').click(function() {
						liveprice_recalc(50);
					});
					
					if ( typeof(lp_non_standard_theme) != 'undefined' && lp_non_standard_theme == 'mstore' ) {
						$('#qty').siblings('.qty').click(function() {
							liveprice_recalc(50);
						});
					}
					
					//magazin
					$('#product .plus, #product .minus').click(function() {
						liveprice_recalc(50);
					});
					
					$('#product .btn-number--plus, #product .btn-number--minus').click(function() {
						liveprice_recalc(50);
					});
					
					//unishop
					$('#product .fa-plus, #product .fa-minus').click(function() {
						liveprice_recalc(100);
					});
					
					// ONStore
					$('#quantity_wanted_p').find('.quantity_down_box, .quantity_up_box').click(function() {
						liveprice_recalc(100);
					});
					
					// July
					if (lp_theme_name == 'julytheme') {
						$('#increase, #decrease').click(function(){
							liveprice_recalc(50);
						});
					}
					
					<?php if ( $lp_theme_name == 'revolution' ) { ?>
						$('.product-info .pokupka, #popup-order-okno').find('.btn-plus, .btn-minus').find('button').click( function(){
							liveprice_recalc(100);
						});
					<?php } ?>
					
					<?php if ( $lp_theme_name == 'themeXXX' ) { ?>
						$('.quantity').find('.counter-plus, .counter-minus').click( function(){
							liveprice_recalc(100);
						});
					<?php } ?>
					
					
					// for Yandex sync module by Toporchillo 
					var hash = window.location.hash;
					if (hash) {
						var hashpart = hash.split('#');
						var hashvals = hashpart[1].split('-');
						for (var hashvals_i=0; hashvals_i<hashvals.length; hashvals_i++) {
							var hashval = hashvals[hashvals_i];
							
							if ( hashval ) {
								$('select[name^="'+lp_option_prefix+'["] option[value="'+hashval+'"]:first').each(function(){
									$(this).parent().val($(this).attr('value'));
									$(this).parent().change();
								});
								
								$('input[name^="'+lp_option_prefix+'["][value="'+hashval+'"]').each( function(){
									$(this).prop('checked', true);
									$(this).change();
								});
							}
						}
					}
					
				}	
				//});
				
				liveprice_init();
				
			</script>
			<?php } ?>
	
	
			<?php // >> Live Price ?>
			
<?php echo $footer; ?>