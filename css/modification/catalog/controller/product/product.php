<?php

class ControllerProductProduct extends Controller
{
    private $error = array();

    public function index()
    {


        $this->load->language('product/product');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $this->load->model('catalog/category');


      // path manager
      if (isset($this->request->get['product_id']) && ((!isset($this->request->get['path']) && $this->config->get('mlseo_fpp_breadcrumbs') == '1') || ($this->config->get('mlseo_fpp_breadcrumbs') == '2')) && is_array($this->request->get)) {
        unset($this->request->get['path']);
        $this->load->model('tool/path_manager');
        $this->request->get = $this->model_tool_path_manager->getFullProductPath($this->request->get['product_id'], true) + $this->request->get;
      }
			
        if (isset($this->request->get['path'])) {
            $path = '';

            $parts = explode('_', (string)$this->request->get['path']);

            $category_id = (int)array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = $path_id;
                } else {
                    $path .= '_' . $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path)
                    );
                }
            }

            // Set the last category breadcrumb
            $category_info = $this->model_catalog_category->getCategory($category_id);

            if ($category_info) {
                $url = '';

                if (isset($this->request->get['sort'])) {
                    $url .= '&sort=' . $this->request->get['sort'];
                }

                if (isset($this->request->get['order'])) {
                    $url .= '&order=' . $this->request->get['order'];
                }

                if (isset($this->request->get['page'])) {
                    $url .= '&page=' . $this->request->get['page'];
                }

                if (isset($this->request->get['limit'])) {
                    $url .= '&limit=' . $this->request->get['limit'];
                }

                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
                );
            }
        }


        $this->load->model('catalog/manufacturer');

        if (isset($this->request->get['manufacturer_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_brand'),
                'href' => $this->url->link('product/manufacturer')
            );

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

            if ($manufacturer_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $manufacturer_info['name'],
                    'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
                );
            }
        }

        if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
            $url = '';

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_search'),
                'href' => $this->url->link('product/search', $url)
            );
        }

        if (isset($this->request->get['product_id'])) {
            $product_id = (int)$this->request->get['product_id'];
        } else {
            $product_id = 0;
        }


        $this->load->model('catalog/product');

        $data['product_downloads'] = $this->model_catalog_product->getDownloads($product_id);

        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $product_info['name'],
                'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
            );

            
      if ($this->config->get('mlseo_enabled')) {
        $this->document->setTitle(!empty($product_info['meta_title']) ? $product_info['meta_title'] : $product_info['name']);
        $data['image_alt'] = !empty($product_info['image_alt']) ? $product_info['image_alt'] : '';
        $data['image_title'] = !empty($product_info['image_title']) ? $product_info['image_title'] : '';
      } else {
        $this->document->setTitle($product_info['meta_title']);
      }
      
            $this->document->setDescription($product_info['meta_description']);
            $this->document->setKeywords($product_info['meta_keyword']);
            $this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
            
            
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

            $data['heading_title'] = !empty($product_info['seo_h1']) && $this->config->get('mlseo_enabled') ? $product_info['seo_h1'] : $product_info['name'];
      
      if (substr(VERSION, 0, 1) == 2) {
        $data['seo_h1'] = !empty($product_info['seo_h1']) ? $product_info['seo_h1'] : '';
        $data['seo_h2'] = !empty($product_info['seo_h2']) ? $product_info['seo_h2'] : '';
        $data['seo_h3'] = !empty($product_info['seo_h3']) ? $product_info['seo_h3'] : '';
      } else {
        $this->data['seo_h1'] = !empty($product_info['seo_h1']) ? $product_info['seo_h1'] : '';
        $this->data['seo_h2'] = !empty($product_info['seo_h2']) ? $product_info['seo_h2'] : '';
        $this->data['seo_h3'] = !empty($product_info['seo_h3']) ? $product_info['seo_h3'] : '';
      }
      
      $this->load->model('catalog/review');
      
      $data['seo_reviews'] = '';
      
      if ($this->config->get('mlseo_reviews')) {
        $gkd_seo_reviews = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], 0, (int)$this->config->get('mlseo_reviews'));
        
        if (count($gkd_seo_reviews)) {
          $data['seo_reviews'] .= '<div class="seo_reviews">';
            foreach ($gkd_seo_reviews as $review) {
              $data['seo_reviews'] .= '<table class="table table-striped table-bordered seo_review">';
              $data['seo_reviews'] .= '<tr>';
              $data['seo_reviews'] .= '  <td style="width: 50%;"><strong>' . $review['author']. '</strong></td>';
              $data['seo_reviews'] .= '  <td class="text-right">' . $review['date_added']. '</td>';
              $data['seo_reviews'] .= '</tr>';
              $data['seo_reviews'] .= '<tr>';
              $data['seo_reviews'] .= '  <td colspan="2"><p>' . $review['text']. '</p>';
              for ($i = 1; $i <= 5; $i++) { 
                if ($review['rating'] < $i) {
                  $data['seo_reviews'] .= '    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>';
                } else {
                  $data['seo_reviews'] .= '    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>';
                }
              }
              $data['seo_reviews'] .= '  </td>';
              $data['seo_reviews'] .= '</tr>';
              $data['seo_reviews'] .= '</table>';
            }
          $data['seo_reviews'] .= '</div>';
        }
      }
      

			
			// << Live Price
			if ( get_class() != 'ControllerProductFntProductDesign' ) {
				$this->load->model('module/liveprice');
				$data['liveprice_installed'] = $this->model_module_liveprice->installed();
				if ( isset($this->request->get['pid']) ) {
					$data['product_id'] = $this->request->get['pid'];
				} elseif ( isset($this->request->get['product_id']) ) {
					$data['product_id'] = $this->request->get['product_id'];
				} elseif ( isset($this->request->post['product_id']) ) {
					$data['product_id'] = $this->request->post['product_id'];
				} else {
					$data['product_id'] = 0;
				}
				$data['lp_theme_name'] = $this->model_module_liveprice->getThemeName();
				$data['liveprice_settings'] = $this->config->get('liveprice_settings');
			}
			// >> Live Price
			
			

            $data['text_select'] = $this->language->get('text_select');
            $data['text_manufacturer'] = $this->language->get('text_manufacturer');
            $data['text_model'] = $this->language->get('text_model');
            $data['text_reward'] = $this->language->get('text_reward');
            $data['text_points'] = $this->language->get('text_points');
            $data['text_stock'] = $this->language->get('text_stock');
            $data['text_discount'] = $this->language->get('text_discount');
            $data['text_tax'] = $this->language->get('text_tax');
            $data['text_option'] = $this->language->get('text_option');
            $data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_write'] = $this->language->get('text_write');
            $data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
            $data['text_note'] = $this->language->get('text_note');
            $data['text_tags'] = $this->language->get('text_tags');
            $data['text_related'] = $this->language->get('text_related');
            $data['text_loading'] = $this->language->get('text_loading');

            $data['entry_qty'] = $this->language->get('entry_qty');
            $data['entry_name'] = $this->language->get('entry_name');
            $data['entry_review'] = $this->language->get('entry_review');
            $data['entry_rating'] = $this->language->get('entry_rating');
            $data['entry_good'] = $this->language->get('entry_good');
            $data['entry_bad'] = $this->language->get('entry_bad');

            $data['button_cart'] = $this->language->get('button_cart');
            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_compare'] = $this->language->get('button_compare');
            $data['button_upload'] = $this->language->get('button_upload');
            $data['button_continue'] = $this->language->get('button_continue');

            $this->load->model('catalog/review');

            $data['tab_description'] = $this->language->get('tab_description');
            $data['tab_attribute'] = $this->language->get('tab_attribute');
            $data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);

            $data['product_id'] = (int)$this->request->get['product_id'];
            $data['manufacturer'] = $product_info['manufacturer'];
            $data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
            $data['model'] = $product_info['model'];
            $data['reward'] = $product_info['reward'];
            $data['points'] = $product_info['points'];

            if ($product_info['quantity'] <= 0) {
                $data['stock'] = $product_info['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $data['stock'] = $product_info['quantity'];
            } else {
                $data['stock'] = $this->language->get('text_instock');
            }

            $this->load->model('tool/image');

            if ($product_info['image']) {
                $data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
            } else {
                $data['popup'] = '';
            }

            if ($product_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
            } else {
                $data['thumb'] = '';
            }

// Start cloud zoom
if ($product_info['image']) {
$data['small'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height'));
} else {
$data['small'] = '';
}
// Cosyone ends

            $data['images'] = array();

            $results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

            foreach ($results as $result) {
                $data['images'][] = array(
                    'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
                    // Cloud zoom thumb start
'small' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),
//Cloud zoom thumb ends
// New thumb function
'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'))
// Cosyone ends

                );
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $data['price'] = false;
            }

            if ((float)$product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));

			  $data['sales_percantage_main'] = round((($product_info['price'] - $product_info['special']) / $product_info['price'] * 100));
			  // Cosyone ends
			   
            } else {
                $data['special'] = false;
            }

            if ($this->config->get('config_tax')) {
                $data['tax'] = $this->currency->format((float)$product_info['special'] ? $product_info['special'] : $product_info['price']);
            } else {
                $data['tax'] = false;
            }


			// Cosyone start
			$data['cosyone_product_zoom'] = $this->config->get('cosyone_product_zoom');
				$data['cosyone_product_share'] = $this->config->get('cosyone_product_share');
				$data['cosyone_percentage_sale_badge'] = $this->config->get('cosyone_percentage_sale_badge');
				$data['cosyone_product_yousave'] = $this->config->get('cosyone_product_yousave');
				$cosyone_quicklook = $this->config->get('cosyone_text_ql');
				if(empty($cosyone_quicklook[$this->language->get('code')])) {
					$data['cosyone_text_ql'] = false;
				} else if (isset($cosyone_quicklook[$this->language->get('code')])) {
					$data['cosyone_text_ql'] = html_entity_decode($cosyone_quicklook[$this->language->get('code')], ENT_QUOTES, 'UTF-8');
				}
				$data['cosyone_product_countdown'] = $this->config->get('cosyone_product_countdown');
				$data['cosyone_product_hurry'] = $this->config->get('cosyone_product_hurry');
				$data['cosyone_image_options'] = $this->config->get('cosyone_image_options');
				$data['cosyone_grid_related'] = $this->config->get('cosyone_grid_related');
				$data['cosyone_brand'] = $this->config->get('cosyone_brand');
			if ((float)$product_info['special']) {
    		$special_info = $this->model_catalog_product->getSpecialPriceEnd($product_id);
        	$data['special_date_end'] = strtotime($special_info['date_end']) - time();
			$data['yousave'] = $this->currency->format(($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))-($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax'))));
			
    		} else {
        	$data['special_date_end'] = false;
    		}
			$this->load->language('common/cosyone');
			$data['text_special_price'] = $this->language->get('text_special_price');
			$data['text_old_price'] = $this->language->get('text_old_price');
			$data['text_you_save'] = $this->language->get('text_you_save');
			$data['text_expire'] = $this->language->get('text_expire');
			$data['text_items_sold'] = sprintf($this->language->get('text_items_sold'), $this->model_catalog_product->getItemsSold($product_id));
			$data['data_qty'] = $product_info['quantity'];
			$data['text_stock_quantity'] = sprintf($this->language->get('text_stock_quantity'), $product_info['quantity']);
			$data['count_reviews'] = $product_info['reviews'];
			$data['thumb_width'] = $this->config->get('config_image_thumb_width');
			$data['additional_width'] = $this->config->get('config_image_additional_width');
			$data['additional_height'] = $this->config->get('config_image_additional_height');
			$data['currency_code'] = $this->currency->getCode();
			$data['lang'] = $this->language->get('code');
			
			// Cosyone end
			   
            $discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

            $data['discounts'] = array();

            foreach ($discounts as $discount) {
                $data['discounts'][] = array(
                    'quantity' => $discount['quantity'],
                    'price' => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
                );
            }

            $data['options'] = array();

            foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));

			// << Live Price
			
			if (($option_value['price_prefix'] == '*' || $option_value['price_prefix'] == '/' || $option_value['price_prefix'] == '%')
				&& (!isset($option_value['hide']) || !$option_value['hide'] ) ) {
				// special way
				$price = (float)$option_value['price'];
			/*	
			} else {
				//standard way
				$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
				*/
			}
			
			// >> Live Price
			
			
                        } else {
                            $price = false;
                        }

                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'],
                            'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
                            'price' => $price,
                            'price_prefix' => $option_value['price_prefix']
                        );
                    }
                }

                $data['options'][] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id' => $option['option_id'],
                    'name' => $option['name'],
                    'type' => $option['type'],
                    'value' => $option['value'],
                    'required' => $option['required']
                );
            }

            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            } else {
                $data['minimum'] = 1;
            }

            $data['review_status'] = $this->config->get('config_review_status');

            if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
                $data['review_guest'] = true;
            } else {
                $data['review_guest'] = false;
            }

            if ($this->customer->isLogged()) {
                $data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
            } else {
                $data['customer_name'] = '';
            }

            $data['reviews'] = sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']);
            $data['rating'] = (int)$product_info['rating'];
            $data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
            $data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

            $data['products'] = array();

for( $i=1; $i< 6; $i++) {
					$data['product_tabs_' . $i] = array();
				}

				$product_tabs = $this->model_catalog_product->getProductTabs($this->request->get['product_id']);

				foreach ($product_tabs as $product_tab) {

					$data['product_tabs_' . $product_tab['position']][] = array(
						'tab_id' 	=> $product_tab['tab_id'],
						'name'    => $product_tab['name'],
						'text'    => html_entity_decode($product_tab['text'], ENT_QUOTES, 'UTF-8')
					);
				}
            $results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float)$result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int)$result['rating'];
                } else {
                    $rating = false;
                }


			  if ((float)$result['special']) {
				$sales_percantage = ((($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')))-($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax'))))/(($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')))/100));
				} else {
				$sales_percantage = false;
				}
				// Cosyone ends
			   
                $data['products'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '...',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating' => $rating,
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }

            $data['elements'] = array();

            $resultsEl = $this->model_catalog_product->getProductElements($this->request->get['product_id']);

            foreach ($resultsEl as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float)$result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int)$result['rating'];
                } else {
                    $rating = false;
                }

                $data['elements'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'name' => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '...',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating' => $rating,
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }

            $filter_data = array(
                'filter_category_id' => $category_id
            );

            if (isset($this->session->data['cat'])) {
                $cat_id = $this->session->data['cat'];
            } else {
                $cat_id = $category_id;
            }

            if (!empty($cat_id)) {
                $filter_data = array(
                    'filter_category_id' => $cat_id
                );
            } else {
                $filter_data = array(
                    'filter_category_id' => ''
                );
            }

            $filter_data['filter_bfilter'] = true;
            $category_products = $this->model_catalog_product->getProducts($filter_data);
            $prevFixProduct = array();
            $prevProduct = array();
            $nextProduct = array();

            foreach ($category_products as $product) {
                if ($product['product_id'] == $product_id) {
                    $prevProduct = $prevFixProduct;
                } else {
                    if (!empty($prevFixProduct) && $prevFixProduct['product_id'] == $product_id) {
                        $nextProduct = $product;
                        break;
                    }
                }
                $prevFixProduct = $product;
            }

            $this->load->model('tool/image');

            if (!empty($prevProduct) && !empty($category_id)) {
                $data['prevProduct'] = array(
                    'name' => $prevProduct['name'],
                    'href' => $this->url->link('product/product', 'product_id=' . $prevProduct['product_id'] . '&path=' . $cat_id)
                );
            }

            if (!empty($nextProduct) && !empty($category_id)) {
                $data['nextProduct'] = array(
                    'name' => $nextProduct['name'],
                    'href' => $this->url->link('product/product', 'product_id=' . $nextProduct['product_id'] . '&path=' . $cat_id)
                );
            }


            $data['tags'] = array();

            if ($product_info['tag']) {
                $tags = explode(',', $product_info['tag']);

                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            $data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
            $data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

            $this->model_catalog_product->updateViewed($this->request->get['product_id']);

      if ($this->config->get('mlseo_enabled')) {
        $this->load->model('tool/seo_package');
        
        if ($this->config->get('mlseo_opengraph')) {
          if (substr(VERSION, 0, 1) == 2) {
            $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('opengraph', 'product', $data + array('product_info' => $product_info)));
          } else {
            $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('opengraph', 'product', $this->data + array('product_info' => $product_info)));
          }
        }

        if ($this->config->get('mlseo_tcard')) {
          if (substr(VERSION, 0, 1) == 2) {
            $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('tcard', 'product', $data + array('product_info' => $product_info)));
          } else {
            $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('tcard', 'product', $this->data + array('product_info' => $product_info)));
          }
        }

        if ($this->config->get('mlseo_microdata')) {
          if (substr(VERSION, 0, 1) == 2) {
            $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('microdata', 'product', $data + array('product_info' => $product_info)));
          } else {
            $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('microdata', 'product', $this->data + array('product_info' => $product_info)));
          }
        }
      }
      

			$data['question_status'] = $this->config->get('product_question_status');
			$data['product_questions'] = $this->load->controller('product/question');
			$this->load->language('product/question');
			$data['tab_questions'] = $this->language->get('tab_questions');
			$data['button_ask'] = $this->language->get('button_ask');
			$this->load->model('catalog/question');
			$data['questions_total'] = $this->model_catalog_question->getTotalQuestionsByProductId($this->request->get['product_id']);
			

            if ($this->config->get('config_google_captcha_status')) {
                $this->document->addScript('https://www.google.com/recaptcha/api.js');

                $data['site_key'] = $this->config->get('config_google_captcha_public');
            } else {
                $data['site_key'] = '';
            }

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            /*	$nowlink =  (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
            if($this->url->link('product/product', 'product_id=' . $product_id)!=$nowlink)
            {
                $this->response->redirect($this->url->link('product/product', 'product_id=' . $product_id), 301);
            }*/

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/product.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/product/product.tpl', $data));
            }
        } else {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title'] = $this->language->get('text_error');

            $data['text_error'] = $this->language->get('text_error');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
            }
        }
    }

    public function review()
    {
        $this->load->language('product/product');

        $this->load->model('catalog/review');

        $data['text_no_reviews'] = $this->language->get('text_no_reviews');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['reviews'] = array();

        $review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

        $results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

        foreach ($results as $result) {
            $data['reviews'][] = array(
                'author' => $result['author'],
                'text' => nl2br($result['text']),
                'rating' => (int)$result['rating'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }

        $pagination = new Pagination();
        $pagination->total = $review_total;
        $pagination->page = $page;
        $pagination->limit = 5;
        $pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/review.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/product/review.tpl', $data));
        }
    }

    public function write()
    {
        $this->load->language('product/product');

        $json = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }

            // Email acceptation
            if ((utf8_strlen($this->request->post['email']) < 3) || (utf8_strlen($this->request->post['email']) > 64)) {
                $json['error'] = $this->language->get('error_email');
            }

            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }

            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $json['error'] = $this->language->get('error_rating');
            }

            if ($this->config->get('config_google_captcha_status') && empty($json['error'])) {
                if (isset($this->request->post['g-recaptcha-response'])) {
                    $recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

                    $recaptcha = json_decode($recaptcha, true);

                    if (!$recaptcha['success']) {
                        $json['error'] = $this->language->get('error_captcha');
                    }
                } else {
                    $json['error'] = $this->language->get('error_captcha');
                }
            }

            if (!isset($json['error'])) {
                $this->load->model('catalog/review');

                $this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

                $json['success'] = $this->language->get('text_success');
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getRecurringDescription()
    {
        $this->language->load('product/product');
        $this->load->model('catalog/product');

        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        if (isset($this->request->post['recurring_id'])) {
            $recurring_id = $this->request->post['recurring_id'];
        } else {
            $recurring_id = 0;
        }

        if (isset($this->request->post['quantity'])) {
            $quantity = $this->request->post['quantity'];
        } else {
            $quantity = 1;
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);
        $recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

        $json = array();

        if ($product_info && $recurring_info) {
            if (!$json) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year'),
                );

                if ($recurring_info['trial_status'] == 1) {
                    $price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));
                    $trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
                } else {
                    $trial_text = '';
                }

                $price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));

                if ($recurring_info['duration']) {
                    $text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                } else {
                    $text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                }

                $json['success'] = $text;
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }


    public function download()
    {

        $this->load->model('catalog/product');

        if (isset($this->request->get['download_id'])) {
            $download_id = $this->request->get['download_id'];
        } else {
            $download_id = 0;
        }

        $download_info = $this->model_catalog_product->getDownload($download_id);

        if ($download_info) {
            $file = DIR_DOWNLOAD . $download_info['filename'];
            $mask = basename($download_info['mask']);

            if (!headers_sent()) {
                if (file_exists($file)) {
                    header('Content-Type: application/pdf');
                    header('Content-Disposition: inline; filename="' . ($mask ? $mask : basename($file)) . '"');
                    header('Expires: 0');
                    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
                    header('Pragma: public');
                    header('Content-Length: ' . filesize($file));

                    if (ob_get_level()) {
                        ob_end_clean();
                    }

                    readfile($file, 'rb');

                    exit();
                } else {
                    exit('Error: Could not find file ' . $file . '!');
                }
            } else {
                exit('Error: Headers already sent out!');
            }
        } else {
            $this->response->redirect($this->url->link('account/download', '', 'SSL'));
        }
    }
}
