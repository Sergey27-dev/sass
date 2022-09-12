<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" itemscope itemtype="http://schema.org/WebPage">
<!--<![endif]-->

<head prefix="og: http://ogp.me/ns#">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="theme-color" content="#464348" />
    
    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>" />
    <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
        <meta name="keywords" content="<?php echo $keywords; ?>" />
    <?php } ?>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <?php if ($icon) { ?>
        <link href="<?php echo $icon; ?>" rel="icon" />
    <?php } ?>

<?php if (!empty($mlseo_meta)) { echo $mlseo_meta; } ?>

<?php foreach ($hreflangs as $link) { ?>
<link rel="alternate" href="<?php echo $link['href']; ?>" hreflang="<?php echo $link['hreflang']; ?>">
<?php } ?>
      
    <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    <meta name="yandex-verification" content="de16b2dbc5bdcace" />
    <meta property="og:type" content="website">
    <meta name="og:image" content="/image/catalog/og-min.png" />
    <meta name="og:title" content="<?php echo $title; ?>" />
    <meta name="og:description" content="<?php echo $description; ?>" />
    <meta name="og:url" content="<?php echo $now_link; ?>" />
    <?php if ($yawebm) { ?>
        <meta name="yandex-verification" content="<?= $yawebm ?>" />
    <?php } ?>
    <link rel="stylesheet preconnect" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha256-NJWeQ+bs82iAeoT5Ktmqbi3NXwxcHlfaVejzJI2dklU=" crossorigin="anonymous" media="screen" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
        <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
    <link rel="stylesheet preload" type="text/css" href="catalog/view/theme/cosyone/stylesheet/stylesheet.css" as="style" />
    <link rel="stylesheet preload" type="text/css" href="catalog/view/theme/cosyone/font/stylesheet.css" as="style" />
    <link rel="stylesheet preload" type="text/css" href="catalog/view/theme/cosyone/stylesheet/style.css?v=4.7.6" as="style" />
    <link rel="stylesheet preload" type="text/css" href="catalog/view/theme/cosyone/stylesheet/style_d.css?v=4.7.0" as="style" />
    <link rel="stylesheet prefetch" type="text/css" href="catalog/view/theme/cosyone/stylesheet/grid/<?php echo $cosyone_max_width; ?>.css" />
    <?php if ($cosyone_use_responsive == 'enabled') { ?>
        <link rel="stylesheet prefetch" type="text/css" href="catalog/view/theme/cosyone/stylesheet/responsive.css" />
    <?php } ?>
    <link rel="preload" href="/catalog/view/javascript/font-awesome/fonts/fontawesome-webfont.woff2?v=4.7.0" as="font" type="font/woff2" crossorigin>
    <link rel="stylesheet prefetch" type="text/css" href="catalog/view/theme/cosyone/stylesheet/jquery.fancybox.css" />
    <link rel="stylesheet prefetch" type="text/css" href="catalog/view/theme/cosyone/stylesheet/animate.min.css" />
    <?php foreach ($styles as $style) { ?>
        <link rel="<?php echo $style['rel']; ?> prefetch" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>
    <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" rel="prefetch"></script>
  
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
    <!--[if IE 8]>
    <link rel="stylesheet" type="text/css" href="catalog/view/theme/cosyone/stylesheet/ie8.css"/>
    <![endif]-->
    <?php echo $google_analytics; ?>
    <?php echo $cosyone_styles; ?>
</head>

<body class="<?php echo $class; ?> <?php echo $cosyone_default_product_style; ?> <?php if ($cosyone_use_custom) {
                                                                                        echo $cosyone_container_layout;
                                                                                    } ?> <?php echo $cosyone_use_breadcrumb; ?>">
    <?php if ($yametr != "") { ?>
        <!-- Yandex.Metrika counter -->
        <script type="text/javascript">
            (function(m, e, t, r, i, k, a) {
                m[i] = m[i] || function() {
                    (m[i].a = m[i].a || []).push(arguments)
                };
                m[i].l = 1 * new Date();
                k = e.createElement(t), a = e.getElementsByTagName(t)[0], k.async = 1, k.src = r, a.parentNode.insertBefore(k, a)
            })
            (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");
            ym(<?= $yametr ?>, "init", {
                clickmap: true,
                trackLinks: true,
                accurateTrackBounce: true,
                webvisor: true
            });
        </script>
        <noscript>
            <div><img src="https://mc.yandex.ru/watch/<?= $yametr ?>" style="position:absolute; left:-9999px;" alt="" />
            </div>
        </noscript>
        <!-- /Yandex.Metrika counter -->
    <?php } ?>
    <?php if ($googleconsole != "") { ?>
        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=<?= $googleconsole ?>"></script>
        <script>
            window.dataLayer = window.dataLayer || [];

            function gtag() {
                dataLayer.push(arguments);
            }

            gtag('js', new Date());
            gtag('config', '<?= $googleconsole ?>');
        </script>
    <?php } ?>
    <script>
        function callback_callback() {
            <?php if ($yametr != "") { ?>
                yaCounter<?= $yametr ?>.reachGoal('callback');
            <?php } ?>
            <?php if ($googleconsole != "") { ?>
                gtag('event', 'callback');
            <?php } ?>
        }
        jQuery(document).ready(function() {
            jQuery('a[href^="tel:"]').on('click touchend', function() {
                <?php if ($yametr != "") { ?>
                    yaCounter<?= $yametr ?>.reachGoal('phoneclick');
                <?php } ?>

                <?php if ($googleconsole != "") { ?>
                    gtag('event', 'phoneclick');
                <?php } ?>
            });
            jQuery('a[href^="mailto:"]').on('click touchend', function() {
                <?php if ($yametr != "") { ?>
                    yaCounter<?= $yametr ?>.reachGoal('mailclick');
                <?php } ?>
                <?php if ($googleconsole != "") { ?>
                    gtag('event', 'mailclick');
                <?php } ?>
            });
        });
    </script>
    <?php echo $cosyone_cookie; ?>
    <div class="fake_menu"></div>
    <div class=" mm-page mm-slideout page">
        <header>
            <div class="outer_container ">
                <div class="header_wrapper
				<?php echo $cosyone_menu_border; ?> 
				<?php echo $cosyone_header_style; ?>">
                    <div class="container-fluid header">
                        <div class="row contact-header d-none d-sm-flex">
                            <div class="">
                                <div class="header-address">
                                    <img src="/image/location.png" alt=""><?php echo $address; ?>
                                </div>
                            </div>
                            <div class="">
                                <div class="header-worktime"><img src="/image/clock.png" alt=""> <span><b>Режим работы: </b>пн-вс 09:00-20:00</span>
                                </div>
                            </div>
                            <div class="">
                                <div class="header-social"><img src="/image/share.png" alt=""> <span>Социальные сети</span>
                                    <a target="_blank" href="https://vk.com/yoohome"><img src="/image/vk.png" alt=""></a>
                                    <!--<a target="_blank" href="https://instagram.com/yoo.home.mebel?u...=copy_link"><img src="/image/instagram.png" alt=""></a>-->
                                    <a target="_blank" href="https://ok.ru/group/59888672964744"><img src="/image/odnoklassniki.png" alt=""></a>
                                </div>
                            </div>
                            <div class="">
                                <div class="header-phone">
                                    <img src="/image/phone-call.png" alt="">
                                    <a href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
                                    <p><a href="tel:<?php echo $fax; ?>"><?php echo $fax; ?></a></p>
                                    <!--<p><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></p>-->
                                    <button class="btnModal" data-toggle="modal" data-target="#myModal" data-name='Обратная связь' data-from='Форма на главной странице'>Заказать звонок
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="header_main">
                            <div class="header_right">
                                <div class="row">
                                    <div class="col-md-2 d-none d-md-block">
                                        <?php if ($logo) { ?>
                                            <div class="logo">
                                                <a href="/"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                                            </div>
                                        <?php } ?>
                                    </div>
                                    <div class=col-md-9>
                                        <?php if ($categories) { ?>
                                            <div class="menu_wrapper_custom">
                                                <div class=" menu_border"></div>
                                                <div class=" menu_holder">
                                                    <div id="menu">
                                                        <?php if ($cosyone_header_style == 'header2') { ?>
                                                        <?php } else { ?>
                                                        <?php } ?>
                                                        <ul class="only_desktop">
                                                            <li class="home only_desktop <?php echo $cosyone_show_home_icon; ?>">
                                                                <a <?php echo ((isset($router['route'])) ? "href='" . $home . "'" : ""); ?>><?php echo $text_home; ?></a>
                                                            </li>
                                                            <?php foreach ($categories as $category_1) { ?>
                                                                <?php if ($category_1['category_1_id'] == $category_1_id) { ?>
                                                                    <li class="col<?php echo $category_1['column']; ?> current">
                                                                        <a <? echo (($router['route'] == "product/category" && $router['path'] == "59") ? "" : "href='" . $category_1['href'] . "'"); ?>><?php echo $category_1['name']; ?><i class="fa fa-sort-desc"></i></a>
                                                                    <?php } else { ?>
                                                                    <li class="col<?php echo $category_1['column']; ?>"><a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?>
                                                                            <i class="fa fa-sort-desc"></i></a>
                                                                    <?php } ?>
                                                                    <?php if ($category_1['children']) { ?>
                                                                        <div class="menu_drop_down" style="width: <?php echo ((($category_1['column']) * (195)) + (10)); ?>px">
                                                                            <div class="wrapper">
                                                                                <ul><?php foreach ($category_1['children'] as $category_2) { ?>
                                                                                        <li class="column level2">
                                                                                            <a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?>
                                                                                                <i class="fa fa-caret-right"></i></a>
                                                                                            <?php if ($cosyone_menu_mega_second_thumb == 'enabled' && $category_2['thumb']) { ?>
                                                                                                <img src="<?php echo $category_2['thumb']; ?>" alt="<?php echo $category_2['name']; ?>" />
                                                                                            <?php } ?>
                                                                                            <?php if ($category_2['children']) { ?>
                                                                                                <div class="third">
                                                                                                    <ul>
                                                                                                        <?php foreach ($category_2['children'] as $category_3) { ?>
                                                                                                            <li>
                                                                                                                <a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a>
                                                                                                            </li>
                                                                                                        <?php } ?>
                                                                                                    </ul>
                                                                                                </div>
                                                                                            <?php } ?>
                                                                                        </li>
                                                                                    <?php } ?>
                                                                                </ul>
                                                                            </div><!-- wrapper ends -->
                                                                        </div>
                                                                    <?php } ?>
                                                                    </li>
                                                                <?php } ?>
                                                                <?php if ($cosyone_custom_menu_block == 'enabled') { ?>
                                                                    <li class="withsubs custom_block">
                                                                        <a><?php echo $cosyone_custom_menu_block_title; ?><i class="fa fa-sort-desc"></i></a>
                                                                        <div class="menu_drop_down" style="width:<?php echo $cosyone_menu_block_width; ?>px">
                                                                            <?php echo $cosyone_menu_custom_block_content; ?>
                                                                        </div>
                                                                    </li>
                                                                <?php } ?>
                                                                <?php if ($cosyone_custom_menu_title1) { ?>
                                                                    <li>
                                                                        <a href="<?php echo $cosyone_custom_menu_url1 ?>"><?php echo $cosyone_custom_menu_title1; ?></a>
                                                                    </li>
                                                                <?php } ?>
                                                                <?php if ($cosyone_custom_menu_title2) { ?>
                                                                    <li>
                                                                        <a href="<?php echo $cosyone_custom_menu_url2 ?>"><?php echo $cosyone_custom_menu_title2; ?></a>
                                                                    </li>
                                                                <?php } ?>
                                                                <?php if (!empty($blog_categories)) { ?>
                                                                    <?php foreach ($blog_categories as $blog_category) { ?>
                                                                        <li <? echo (($_SERVER['REQUEST_URI'] == '/' . $blog_category['href'] || isset($router) && $router['route'] == 'blog/blog') ? 'class="current"' : ''); ?>>
                                                                            <a <? echo (($_SERVER['REQUEST_URI'] == '/' . $blog_category['href'] || isset($router) && $router['route'] == 'blog/blog') ? '' : 'href="' . $blog_category['href'] . '"'); ?>><?php echo $blog_category['name']; ?></a>
                                                                        </li>
                                                                    <?php } ?>
                                                                <?php } ?>
                                                                <?php if (!empty($informations)) { ?>
                                                                    <?php foreach ($informations as $information) { ?>
                                                                        <li <? echo (($_SERVER['REQUEST_URI'] == '/' . $information['href']) ? 'class="current"' : ''); ?>>
                                                                            <a <? echo (($_SERVER['REQUEST_URI'] == '/' . $information['href']) ? '' : 'href="' . $information['href'] . '"'); ?>><?php echo $information['title']; ?></a>
                                                                        </li>
                                                                    <?php } ?>
                                                                <?php } ?>
                                                                <?php if (!empty($galls)) { ?>
                                                                    <?php $request = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://" . $_SERVER['SERVER_NAME'] . $_SERVER['REQUEST_URI']; ?>
                                                                    <?php foreach ($galls as $gall) { ?>
                                                                        <li <? echo (($request == $gall['href']) ? 'class="current"' : ''); ?>>
                                                                            <a <? echo (($request == $gall['href']) ? '' : 'href="' . $gall['href'] . '"'); ?>><?php echo $gall['name']; ?></a>
                                                                        </li>
                                                                    <?php } ?>
                                                                <?php } ?>
                                                                <?/*php if (isset($router['route']) && $router['route'] == 'product/testimonial') { ?>
                                                                    <li class="current"><a>Отзывы</a></li>
                                                                <?php } else { ?>
                                                                    <li><a href="/?route=product/testimonial">Отзывы</a></li>
                                                                <?php } */?>
                                                                <? if (isset($router['route']) && $router['route'] == 'information/contact') { ?>
                                                                    <li class="current"><a>Контакты</a></li>
                                                                <?php } else { ?>
                                                                    <li><a href="/?route=information/contact">Контакты</a></li>
                                                                <?php } ?>
                                                        </ul>
                                                    </div> <!-- menu_holder ends -->
                                                </div> <!-- menu ends -->
                                            </div> <!-- menu_wrapper ends -->
                                        <?php } ?>
                                        <div class="row mob-reverse">
                                            <div class="col-xl-8 col-lg-7 pdt">
                                                <?php if ($cosyone_header_style == 'header3') { ?>
                                                <?php } else { ?>
                                                    <?php if ($cosyone_header_search == 'enabled') { ?>
                                                        <?php echo $search; ?>
                                                    <?php } ?>
                                                <?php } ?>
                                             </div>
                                            <div class="phone phone-m">
                                                <a href="tel:<?php echo $telephone; ?>"><?php echo $telephone; ?></a>
                                            </div>
                                            <div class="col login-flex p-0">
                                                <div class="login-h d-none d-sm-block m-0">
                                                    <?php echo $header_login; ?>
                                                </div>
                                            </div>
                                            <div class="shortcuts_wrapper col pdt">
                                                <div class="mobi-m">
                                                    <div class="mobi-m">
                                                        <a href='#menu2' class="mobile_menu_trigger up_to_tablet"><i class="fa fa-bars"></i></a>
                                                    </div>
                                                </div>
                                                <?php if ($logo) { ?>
                                                    <div class="logo logo-m">
                                                        <a href="/"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                                                    </div>
                                                <?php } ?>
                                                <div class="headerIcons">
                                                    <div class="login-h d-sm-none">
                                                        <?php if ($data['username'] == "") { ?> <a href="/login"><img style="width:19px; height:21px;" src="/image/user.svg" alt=""></a>
                                                        <?php } else {
                                                            echo $data['username']; ?> <span> / </span> <a href="/logout"><img style="width:19px; height:21px;" src="/image/user.svg" alt=""></a> <?php } ?>
                                                    </div>
                                                    <?php echo $header_wishlist_compare; ?>
                                                    <?php if ($cosyone_header_cart) {
                                                        echo $cart;
                                                    } ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row"></div>
                                    <!---------------------------->
                                    <?php if ($cosyone_header_style == 'header2') { ?>
                                        <div class="shortcuts_wrapper">
                                            <?php echo $header_wishlist_compare; ?>
                                            <?php if ($cosyone_header_cart) {
                                                echo $cart;
                                            } ?>
                                        </div>
                                    <?php } else { ?>
                                    <?php } ?>
                                    <?php if ($cosyone_header_style == 'header3') { ?>
                                    <?php } else { ?>
                                </div> <!-- header_right ends -->
                            </div>
                        </div> <!-- header ends -->
                    <?php } ?>
                    <?php if ($cosyone_header_style == 'header3') { ?>
                    </div> <!-- header_right ends -->
                </div> <!-- header ends -->
                <?php } else { ?><?php } ?>
                <div class="clearfix"></div>
            </div> <!-- header_wrapper ends -->
    </div> <!-- inner conainer ends -->
    </header>
    <div class="container-fluid px-5">
        <div class="row">
            <div class="col-sm-12">
                <div class="breadcrumb_wrapper"></div>
                <div id="notification" class="container"></div>
            </div>
        </div>
    </div>
    <?php foreach ($scripts as $script) { ?>
        <script type="text/javascript" src="<?php echo $script; ?>" rel="preconnect"></script>
    <?php } ?>