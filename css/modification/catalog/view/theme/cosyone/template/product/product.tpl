<?php echo $header; ?>
<div class="container-fluid">
    <ul class="breadcrumb" itemscope itemtype="http://schema.org/BreadcrumbList">
        <?php $last_crumb = array_pop($breadcrumbs); ?><?php $position = 1; ?><?php $keys = count($breadcrumbs); ?><?php $last_position = $keys + 1; ?>
        <?php foreach ($breadcrumbs as $breadcrumb) { ?><li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="item"><span itemprop="name"><?php echo $breadcrumb['text']; ?></span></a><meta itemprop="position" content="<?= $position; ?>" /></li><?php $position++; ?> <?php } ?>
        <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"><span itemprop="item"><span itemprop="name"><?php echo $last_crumb['text']; ?></span></span><meta itemprop="position" content="<?= $last_position; ?>" /></li>
    </ul>
    <div class="row"><?php echo $column_left; ?><?php if ($column_left && $column_right) { ?><?php $class = 'col-md-6'; ?><?php } elseif ($column_left || $column_right) { ?><?php $class = 'col-md-9'; ?><?php } else { ?><?php $class = 'col-md-12'; ?> <?php } ?>
        <div id="content" class="col-lg-9 product" itemscope itemtype="http://data-vocabulary.org/Product">
            <?php echo $content_top; ?>
            <div class="product-info row">
                <?php if ($thumb || $images) { ?>
                    <div class="col-lg-7">
                        <noindex>
                        <h1 itemprop="name" class="mobi"><?php echo $heading_title; ?></h1>
                </noindex>
                        <?php if ($thumb) { ?>
                            <div class="image desk">
                                <?php if ($cosyone_product_zoom) { ?>
                                    <a href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" class="cloud-zoom" style="cursor:move" rel="position:'inside', showTitle: false" id='zoom1'>
                                    <img itemprop="image" src="<?php echo $thumb; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>" /></a>
                                    <!-- zoom link-->
                                    <a href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" id="zoom-btn" class="colorbox" rel="colorbox"><i class="fa fa-search-plus"></i></a>
                                <?php } else { ?>
                                    <a href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" class="colorbox"><img itemprop="image" src="<?php echo $thumb; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>" /></a>
                                <?php } ?>

                                <?php if ($cosyone_percentage_sale_badge == 'enabled') { ?>
                                    <?php if (!$special) { ?>
                                    <?php } else { ?>
                                        <div class="sale_badge">-<?php echo $sales_percantage_main; ?>%</div>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        <?php } ?>
                        <?php if ($images) { ?>
                            <div class="image-additional" style="width: 100%; height:<?php echo $additional_height; ?>px">
                                <div class="image_carousel owl-carousel">
                                    <!-- Additional images -->
                                    <div><img class="product-gallery" src="<?php echo $popup ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>"></div>
                                    <?php foreach ($images as $image) { ?>
                                        <div><img class="product-gallery" src="<?php echo $image['popup'] ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>"></div>
                                    <?php } ?>
                                </div>
                                <?php foreach ($images as $image) { ?>
                                    <a href="<?php echo $image['popup']; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" class="colorbox" rel="useZoom: 'zoom1', smallImage: '<?php echo $image['thumb']; ?>'"></a>
                                <?php } ?>
                               
                            </div>
                        <?php } ?>
                        <?php if ($cosyone_product_share == 'image') { ?>
                            <!-- AddThis Button START -->
                            <div class="addthis_toolbox addthis_default_style addthis_32x32_style"><a class="addthis_button_preferred_1"></a><a class="addthis_button_preferred_2"></a><a class="addthis_button_preferred_3"></a><a class="addthis_button_preferred_4"></a><a class="addthis_button_compact"></a><a class="addthis_counter addthis_bubble_style"></a></div>
                            <!-- AddThis Button END -->
                        <?php } ?>
                    </div>
                <?php } ?>
                <div id="product_desc" class="col-lg-4">
                    <h1 itemprop="name" class="desc"><?php echo $heading_title; ?></h1>
                    <?php if ($thumb) { ?>
                        <div class="image mobi">
                            <?php if ($cosyone_product_zoom) { ?>
                                <a href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" class="cloud-zoom" style="cursor:move" rel="position:'inside', showTitle: false" id='zoom1'><img itemprop="image" src="<?php echo $thumb; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>" /></a>
                                <!-- zoom link-->
                                <a href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" id="zoom-btn" class="colorbox" rel="colorbox"><i class="fa fa-search-plus"></i></a>
                                <?php } else { ?>
                                    <a href="<?php echo $popup; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" class="colorbox"><img itemprop="image" src="<?php echo $thumb; ?>" title="<?php echo !empty($image_title) ? $image_title : $heading_title; ?>" alt="<?php echo !empty($image_alt) ? $image_alt : $heading_title; ?>" /></a>
                                <?php } ?>

                            <?php if ($cosyone_percentage_sale_badge == 'enabled') { ?>
                                <?php if (!$special) { ?>
                                <?php } else { ?>
                                    <div class="sale_badge">-<?php echo $sales_percantage_main; ?>%</div>
                                <?php } ?>
                            <?php } ?>
                        </div>

                    <?php } ?>
                    <div class="stockW"><span class="stock"><?php echo $stock; ?></span><a class="sq_icon" onclick="compare.add('<?php echo $product_id; ?>');" data-tooltip="<?php echo $button_wishlist; ?>">Добавить в избранное<i class="fa fa-heart"></i></a></div>
                    <div class="description">
                        <?php if ($manufacturer) { ?> <span class="contrast_font"><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br /><?php } ?>
                        <?php if ($attribute_groups) { ?><div role="tabpanel" class="tab-pane" id=""><table class="attribute"><?php foreach ($attribute_groups as $attribute_group) { ?><tbody><?php foreach ($attribute_group['attribute'] as $attribute) { ?><tr><td><?php echo $attribute['name']; ?>:</td><td><?php echo $attribute['text']; ?></td></tr> <?php } ?></tbody><?php } ?></table></div><?php } ?>
                        <?php if ($reward) { ?><span class="contrast_font"><?php echo $text_reward; ?></span> <?php echo $reward; ?><br /> <?php } ?>
                    </div> <!-- .description ends -->
                    <?php if ($price) { ?>
                        <span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
                            <!-- Rich snippets start -->
                            <meta itemprop="priceCurrency" content="<?php echo $currency_code; ?>" />
                            <meta itemprop="availability" content="<?php if ($data_qty > 0) { echo "В наличии"; } else { echo "Нет в наличии"; } ?>">
                            <?php if (($special) && ($cosyone_product_yousave)) { ?>
                                <div class="extended_offer"><div class="price-new"><?php echo $text_special_price; ?><span class="amount contrast_font" itemprop="price"><?php echo $special; ?></span></div><div class="price-old"><?php echo $text_old_price; ?><span class="amount contrast_font"><?php echo $price; ?></span></div><div class="price-save"><?php echo $text_you_save; ?><span class="amount contrast_font"><?php echo $yousave; ?></span> </div></div>
                            <?php } ?>
                            <?php if (($special_date_end > 0) && ($cosyone_product_countdown)) { ?>
                                <div class="contrast_font">
                                    <div class="offer"></div>
                                </div>
                                <?php if ($cosyone_product_hurry) { ?>
                                    <div class="hurry"><span class="items_left contrast_color"><?php echo $text_stock_quantity; ?></span><span class="items_sold"><?php echo $text_items_sold; ?></span></div>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                        <div id="product">
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
                            <?php if ($options) { ?>
                                <div class="options contrast_font">
                                    <h2><?php echo $text_option; ?></h2>
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
                                            <?php if ($cosyone_image_options == 'thumbs') { ?>
                                                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                    <div id="input-option<?php echo $option['product_option_id']; ?>" class="clean-option-image">
                                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                            <div class="single-option main_font" <?php if ($option_value['price']) { ?>data-tooltip="<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>" <?php } ?>>
                                                                <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name']; ?>" /></label>
                                                            </div>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                            <?php } else { ?>
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
                                                <label class="control-label"><?php echo $option['name']; ?></label><br />
                                                <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="button"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
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
                                                    </span>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'datetime') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <div class="input-group datetime">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'time') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <div class="input-group time">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        <?php } ?>
                                    <?php } ?>
                                </div> <!-- .options ends -->
                            <?php } ?>
                            <div class="cart">
                                <div class="info">
                                    <div class="quantity">
                                        <span class="info_heading">Количество:</span>
                                        <div class="changeQ">
                                            <a class="quantity_button minus icon">-</a><input type="text" name="quantity" value="<?php echo $minimum; ?>" size="1" id="input-quantity" class="quantity" /><a class="quantity_button plus icon">+</a>
                                        </div>
                                        <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                    </div>
                                    <?php if ($price) { ?>
                                        <div class="priceW">
                                            <span class="info_heading">Стоимость:</span>
                                            <div class="price">
                                                <?php if (!$special) { ?>
                                                    <span itemprop="price"><?php echo $price; ?></span>
                                                <?php } else { ?>
                                                    <?php if (!$cosyone_product_yousave) { ?>
                                                        <span class="price-old"><?php echo $price; ?></span> <span class="price-new" itemprop="price"><?php echo $special; ?></span>
                                                    <?php } ?>
                                                <?php } ?>
                                            </div>

                                        </div>
                        </span> <!-- rich snippet ends -->
                    <?php } ?>
                </div>
                <div class="buttons">
                    <button type="submit" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="button contrast"><?php echo $button_cart; ?></button>
                    <button data-toggle="modal" data-target="#myModal" data-name='Купить в один клик: <?php echo $heading_title; ?>' data-from='Купить в один клик: <?php echo $heading_title; ?>' type="submit" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="button contrast oneclick">Купить в один клик</button>
                </div>
            </div> <!-- Cart ends -->
            <?php if ($minimum > 1) { ?>
                <div class="minimum"><?php echo $text_minimum; ?></div>
            <?php } ?>
            <?php if ($price) { ?>
                <?php if ($points) { ?>
                    <div class="reward"><?php echo $text_points; ?><?php echo $points; ?></div>
                <?php } ?>
                <?php if ($discounts) { ?>
                    <div class="discount">
                        <?php foreach ($discounts as $discount) { ?>
                            <span><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></span>
                        <?php } ?>
                    </div>
                <?php } ?>
            <?php } ?>
        </div>
        <div class="share">
            <?php if ($cosyone_product_share == 'content') { ?>
                <!-- AddThis Button START -->
                <div class="addthis_toolbox addthis_default_style addthis_32x32_style">
                    <a class="addthis_button_preferred_1"></a>
                    <a class="addthis_button_preferred_2"></a>
                    <a class="addthis_button_preferred_3"></a>
                    <a class="addthis_button_preferred_4"></a>
                    <a class="addthis_button_compact"></a>
                    <a class="addthis_counter addthis_bubble_style"></a>
                </div>
                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js" rel="preconnect"></script>
                <!-- AddThis Button END -->
            <?php } ?>
            <?php if ($price) { ?>
                <?php if ($tax) { ?>
                    <span class="price-tax"><?php echo $text_tax; ?><?php echo $tax; ?></span><br />
                <?php } ?>
            <?php } ?>
        </div> <!-- .share ends -->
    </div>
    <!-- product-info-right END -->
</div> <!-- product-info END -->
<hr>
<div class="description">
    <?php echo $description; ?>
</div>
<div class="conditions">
    <div class="conditions-area">
        <div class="conditions-item">
            <div class="conditions-img">
                <img src="/catalog/view/theme/cosyone/image/conditions1.png" alt="">
            </div>
            <p><a class="mainLink" href="/dostavka">Доставка</a> за 800 ₽</p>
        </div>
        <div class="conditions-item">
            <div class="conditions-img">
                <img src="/catalog/view/theme/cosyone/image/conditions2.png" alt="">
            </div>
            <p><a class="mainLink" href="/dostavka">Сборка</a> 12 % (от 950 ₽)</p>
        </div>
        <div class="conditions-item">
            <div class="conditions-img">
                <img src="/catalog/view/theme/cosyone/image/conditions3.png" alt="">
            </div>
            <p>Подъем на этаж от 400 ₽</p>
        </div>
        <div class="conditions-item">
            <div class="conditions-img">
                <img src="/catalog/view/theme/cosyone/image/conditions4.png" alt="">
            </div>
            <p>Самовывоз (только по предзаказу)</p>
            <span>г. Новосибирск, ул. Тюменская 2, корп 6. </span>
        </div>
    </div>
</div>
<?php if (count($product_downloads) > 0) { ?>
    <div role="tabpanel" class="tab-pane fade" id="tab-documents">
        <?php foreach ($product_downloads as $item) { ?>
            <a href="/?route=product/product/download&download_id=<?php echo $item['download_id']; ?>" target='_blank'>
                <p><i class="fa fa-file-text-o" aria-hidden="true"></i><?php echo $item['name']; ?></p>
            </a>
        <?php } ?>
    </div>
<?php } ?>
<p class="mt-3 mt-md-0">
    <a id="fbExpand" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Отзывы
    </a>
</p>
<hr>
<div class="collapse" id="collapseExample">
    <div role="tabpanel" class="tab-pane" id="tab-review">
        <div class="row justify-content-between">
            <div class="col-auto">
                <a class="mainLink" data-toggle="collapse" href="#sendReview" role="button" aria-expanded="false" aria-controls="sendReview">
                    Оставить отзыв
                </a>
            </div>
            <div class="col-auto">
                <p><?php echo $reviews ?></p>
            </div>
        </div>
        <div class="collapse" id="sendReview">
            <form id="form-review" class="form-horizontal">
                <div class="write_review contrast_font row">
                    <?php if ($review_guest) { ?>
                        <div class="form-group required col-lg-6">
                            <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                            <input type="text" name="name" value="" id="input-name" class="form-control" />
                            <label class="control-label" for="input-email">Email</label>
                            <input type="email" name="email" value="" id="input-email" class="form-control" />
                        </div>
                        <div class="form-group required col-lg-6">
                            <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                            <textarea name="text" id="input-review" rows="8" style="width: 100%;"></textarea>
                        </div>
                        <div class="form-group required d-none">
                            <div class="col-sm-12">
                                <label class="control-label"><?php echo $entry_rating; ?></label>
                                &nbsp;&nbsp;&nbsp; <span class="main_font"><?php echo $entry_bad; ?></span>&nbsp;
                                <input type="radio" name="rating" value="1" />
                                &nbsp;
                                <input type="radio" name="rating" value="2" />
                                &nbsp;
                                <input type="radio" name="rating" value="3" />
                                &nbsp;
                                <input type="radio" name="rating" value="4" />
                                &nbsp;
                                <input type="radio" name="rating" value="5" checked="checked" />
                                &nbsp;<span class="main_font"><?php echo $entry_good; ?></span>
                            </div>
                        </div>
                        <div class="form-group col row mx-0 px-0">
                            <div class="col-md-9">
                                <input id="politic" type="checkbox">
                                <label for="politic">Нажимая кнопку “Оставить отзыв”, Вы соглашаетесь <a class="mainLink" href="">с Политикой конфиденциальности</a></label>
                            </div>
                            <div class="col-md-3"><a id="button-review" class="button pull-right"><?php echo $button_continue; ?></a></div>
                        </div>
                </div>
            <?php } else { ?>
                <div class="alert alert-info main_font"><?php echo $text_login; ?></div>
            <?php } ?>
            </form>
            <hr>
        </div>
        <div id="review"></div>
    </div>
</div>
<?php if ($product_tabs_5) { ?>
    <?php foreach ($product_tabs_5 as $product_tab_5) { ?>
        <div role="tabpanel" class="tab-pane fade" id="tab-product-tab<?php echo $product_tab_5['tab_id']; ?>">
            <?php echo $product_tab_5['text']; ?>
        </div>
    <?php } ?>
<?php } ?>
<?php if ($elements) { ?>
    <div class="box products">
        <div class="box-heading products">Элементы системы</div>
        <div class="<?php echo $cosyone_grid_related; ?>">
            <div class="grid_holder">
                <div class="product-grid carousel related owl-carousel">
                    <?php foreach ($elements as $product) { ?>
                        <div class="item contrast_font">
                            <div class="myheart">
                                <a class="sq_icon" onclick="compare.add('<?php echo $product['product_id']; ?>');" data-tooltip="<?php echo $button_wishlist; ?>"><i class="fa fa-heart"></i></a>
                            </div>
                            <div class="image">
                                <?php if ($product['special'] && $cosyone_percentage_sale_badge == 'enabled') { ?>
                                    <div class="sale_badge">-<?php echo $product['sales_percantage']; ?>%</div>
                                <?php } ?>
                                <?php if ($product['thumb']) { ?>
                                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                <?php } ?>

                                <?php if ($cosyone_text_ql) { ?>
                                    <div class="main_quicklook">
                                        <a href="<?php echo $product['quickview']; ?>" class="button quickview"><i class="fa fa-eye"></i> <?php echo $cosyone_text_ql; ?></a>
                                    </div>
                                <?php } ?>
                            </div><!-- image ends -->
                            <div class="information_wrapper">
                                <div class="left">
                                    <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    </div>
                                    <div class="inStock">
                                        Наличие: <span><?php echo $stock; ?></span>
                                    </div>
                                </div>
                                <?php if ($product['price']) { ?>
                                    <div class="price d-flex justify-content-between">
                                        <div class="quantity">
                                            <a class="quantity_button minus icon">-</a><input type="text" name="quantity" value="<?php echo $minimum; ?>" size="1" id="input-quantity" class="quantity" /><a class="quantity_button plus icon">+</a>
                                            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                        </div>
                                        <?php if (!$product['special']) { ?>
                                            <?php echo $product['price']; ?>
                                        <?php } else { ?>
                                            <div class="priceW">
                                                <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                            </div>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                                <div class="cart">
                                    <button type="submit" class="button contrast" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                                        <i class="fa fa-shopping-cart"></i> <?php echo $button_cart; ?></button>
                                </div>
                                <div class="icons_wrapper">
                                    <?php if ($cosyone_text_ql) { ?>
                                        <a href="<?php echo $product['quickview']; ?>" class="sq_icon qlook quickview" data-tooltip="<?php echo $cosyone_text_ql; ?>"><i class="fa fa-eye"></i></a>
                                    <?php } ?>
                                    <a class="sq_icon contrast add_to_cart" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" data-tooltip="<?php echo $button_cart; ?>">Купить</a>
                                    <a class="plain_link wishlist" onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a>
                                    <a class="plain_link compare" onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
<?php } ?>
<?php if ($products) { ?>
    <div class="box products">
        <div class="box-heading products"><?php echo $text_related; ?></div>
        <div class="<?php echo $cosyone_grid_related; ?>">
            <div class="grid_holder">
                <div class="product-grid carousel related owl-carousel">
                    <?php foreach ($products as $product) { ?>
                        <div class="item contrast_font">
                            <div class="myheart">
                                <a class="sq_icon" onclick="compare.add('<?php echo $product['product_id']; ?>');" data-tooltip="<?php echo $button_wishlist; ?>"><i class="fa fa-heart"></i></a>
                            </div>
                            <div class="image">
                                <?php if ($product['special'] && $cosyone_percentage_sale_badge == 'enabled') { ?>
                                    <div class="sale_badge">-<?php echo $product['sales_percantage']; ?>%</div>
                                <?php } ?>
                                <?php if ($product['thumb']) { ?>
                                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                <?php } ?>

                                <?php if ($cosyone_text_ql) { ?>
                                    <div class="main_quicklook">
                                        <a href="<?php echo $product['quickview']; ?>" class="button quickview"><i class="fa fa-eye"></i> <?php echo $cosyone_text_ql; ?></a>
                                    </div>
                                <?php } ?>
                            </div><!-- image ends -->
                            <div class="information_wrapper">
                                <div class="left">
                                    <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    </div>
                                    <div class="inStock">
                                        Наличие: <span><?php echo $stock; ?></span>
                                    </div>
                                </div>
                                <?php if ($product['price']) { ?>
                                    <div class="price d-flex justify-content-between">
                                        <div class="quantity">
                                            <a class="quantity_button minus icon">-</a><input type="text" name="quantity" value="<?php echo $minimum; ?>" size="1" id="input-quantity" class="quantity" /><a class="quantity_button plus icon">+</a>
                                            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                        </div>
                                        <?php if (!$product['special']) { ?>
                                            <?php echo $product['price']; ?>
                                        <?php } else { ?>
                                            <div class="priceW">
                                                <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                                            </div>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                                <div class="cart">
                                    <button type="submit" class="button contrast" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                                        <i class="fa fa-shopping-cart"></i> <?php echo $button_cart; ?></button>
                                </div>
                                <div class="icons_wrapper">
                                    <?php if ($cosyone_text_ql) { ?>
                                        <a href="<?php echo $product['quickview']; ?>" class="sq_icon qlook quickview" data-tooltip="<?php echo $cosyone_text_ql; ?>"><i class="fa fa-eye"></i></a>
                                    <?php } ?>
                                    <a class="sq_icon contrast add_to_cart button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');" data-tooltip="<?php echo $button_cart; ?>">Купить</a>
                                    <a class="plain_link wishlist" onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a>
                                    <a class="plain_link compare" onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a>
                                </div>
                            </div>
                        </div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
<?php } ?>
<?php echo $content_bottom; ?></div>
<?php echo $column_right; ?></div>
<script src="catalog/view/theme/cosyone/js/cloud-zoom.1.0.2.min.js" rel="prefetch"></script>
<script>
  
    $(document).ready(function() {
        $('.colorbox').colorbox({
            overlayClose: true,
            maxWidth: '95%',
            rel: 'gallery',
            opacity: 0.5
        });
    });
   
    
</script>
<script>
    jQuery(function($) {
        //Product thumbnails
        $(".cloud-zoom-gallery").last().removeClass("cboxElement");
        $(".cloud-zoom-gallery").click(function() {
            $("#zoom-btn").attr('href', $(this).attr('href'));
            $("#zoom-btn").attr('title', $(this).attr('title'));

            $(".cloud-zoom-gallery").each(function() {
                $(this).addClass("cboxElement");
            });
            $(this).removeClass("cboxElement");
        });

    });
</script>
<script>
    $(document).ready(function() {
        var owlAdditionals = $('.image_carousel');
        var wrapperWidth = $(".image-additional").width();
        var itemWidth = 160;
        var itemcalc = Math.round(wrapperWidth / itemWidth);
        owlAdditionals.owlCarousel({
            items: 5,
            mouseDrag: true,
            nav: true,
            slideSpeed: 200,
            dots: true,
            navText: [
                "<div class='slide_arrow_prev add_img'><i class='fa fa-angle-left'></i></div>",
                "<div class='slide_arrow_next add_img'><i class='fa fa-angle-right'></i></div>"
            ]
        });
    });
</script>
<script>
    $(document).ready(function() {
        var grid5 = 5;
        var grid4 = 4;
        var grid3 = 3;
        var owlRelated = $('.product-grid.related.carousel');
        owlRelated.owlCarousel({
            items: 4,
            responsive: {
                0: {
                    items: 1,
                    nav: false
                },
                400: {
                    items: 1,
                    nav: false
                },
                600: {
                    items: 2,
                    nav: false
                },
                1300: {
                    items: 4,
                    nav: true
                }
            },
            dots: false,
            nav: true,
            slideSpeed: 500,
            scrollPerPage: false,
            autoplay: true,
            navText: [
                "<div class='slide_arrow_prev'><i class='fa fa-angle-left'></i></div>",
                "<div class='slide_arrow_next'><i class='fa fa-angle-right'></i></div>"
            ]
        });
    });
</script>
<script>
    $('.quantity_button.plus').on('click', function() {
        var oldVal = $(this).prev().val();
        var newVal = (parseInt($(this).prev().val(), 10) + 1);
        $(this).prev().val(newVal);
    });
    $('.quantity_button.minus').on('click', function() {
        var oldVal = $(this).next().val();
        if (oldVal > 1) {
            var newVal = (parseInt($(this).next().val(), 10) - 1);
        } else {
            newVal = 1;
        }
        $(this).next().val(newVal);
    });
</script>
<?php if ($special_date_end > 0) { ?>
    <script type="text/javascript" src="catalog/view/theme/cosyone/js/countdown/jquery.countdown.min.js" rel="prefetch"></script>
    <script>
        $('.offer').countdown({
            until: <?php echo $special_date_end ?>,
            layout: '{desc}<i>{dn}</i> {dl} <i>{hn}</i> {hl} <i>{mn}</i> {ml} <i>{sn}</i> {sl}',
            description: '<span class="main_font"><?php echo $text_expire ?></span>&nbsp;'
        });
    </script>
<?php } ?>
<script type="text/javascript">
    $(".to_review").click(function() {
        $('html, body').animate({
            scrollTop: $("#tab-review").offset().top
        }, 1000);
    });
</script>
<!-- Default scrips below -->
<script>
    <!--
    $('select[name=\'recurring_id\'], input[name="quantity"]').change(function() {
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
    //
    -->
</script>
<script>
    <!--
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
                    $('#cart-total').html(json['total']);
                    $('#cart').load('index.php?route=common/cart/info #cart > *'); //Added
                    const modal = document.querySelector('#addToCartConfirm')
                    $('#addToCartConfirm').modal('show')
                    modal.querySelector('.product_name').textContent = json.name
                    modal.querySelector('.product_image').src = `/image/${json.image}`
                }
            }
        });
    });
    //
    -->
</script>
<script>
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
    //-->
</script>
<script>
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
    //-->
</script>
<script>
    document.addEventListener('DOMContentLoaded', gallery);
    function gallery() {
        const thumbs = document.getElementsByClassName('product-gallery')
        thumbs[0].parentElement.parentElement.classList.add('current')
        getThumbWrapper(thumbs[0]).classList.add('current')
        const main_pic = document.querySelector('.product-info').querySelector('.image').children[0].children[0]
        Array.prototype.forEach.call(thumbs, function(el) {
            el.addEventListener('click', (el) => {
                main_pic.src = el.target.src
                for (let thumb of thumbs) {
                    getThumbWrapper(thumb).classList.remove('current')
                }
                getThumbWrapper(el.target).classList.add('current')
            })
        })
    }
</script>
<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js" rel="preconnect"></script>

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