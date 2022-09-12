<?php
class ModelCatalogProduct extends Model {
	public function addProduct($data) {
    $default_lang = $this->db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('config_language') . "'")->row['language_id'];
		$this->event->trigger('pre.admin.product.add', $data);

		
      // handle item id and batch name for universal import
      $univimp_extra = '';
      
      if (!empty($data['product_id']) && defined('GKD_UNIV_IMPORT')) {
        $univimp_extra .= 'product_id = "' . (int) $data['product_id'] . '", ';
      }
      
      if (!empty($data['import_batch']) && defined('GKD_UNIV_IMPORT')) {
        $univimp_extra .= 'import_batch = "' . $this->db->escape($data['import_batch']) . '", ';
      }
      
			$this->db->query("INSERT INTO " . DB_PREFIX . "product SET " . $univimp_extra . " model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', location = '" . $this->db->escape($data['location']) . "', quantity = '" . (int)$data['quantity'] . "', minimum = '" . (int)$data['minimum'] . "', subtract = '" . (int)$data['subtract'] . "', stock_status_id = '" . (int)$data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', shipping = '" . (int)$data['shipping'] . "', price = '" . (float)$data['price'] . "', points = '" . (int)$data['points'] . "', weight = '" . (float)$data['weight'] . "', weight_class_id = '" . (int)$data['weight_class_id'] . "', length = '" . (float)$data['length'] . "', width = '" . (float)$data['width'] . "', height = '" . (float)$data['height'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', tax_class_id = '" . (int)$data['tax_class_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', date_added = NOW()");

		$product_id = $this->db->getLastId();

// CostPrice
		$this->db->query("UPDATE " . DB_PREFIX . "product SET cost = '" . (float)$data['cost'] . "' WHERE product_id = '" . (int)$product_id . "'");
// CostPrice end
			

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($data['image']) . "' WHERE product_id = '" . (int)$product_id . "'");
		}

		foreach ($data['product_description'] as $language_id => $value) {

      if ($this->config->get('mlseo_enabled')) {
        if ($this->config->get('mlseo_insertautotitle')) {
          $value['name'] = ($value['name']) ? $value['name'] : $data['product_description'][$default_lang]['name'];
          $value['description'] = ($value['description']) ? $value['description'] : $data['product_description'][$default_lang]['description'];
        }
        
        $this->load->model('tool/seo_package');
      
        $data['product_id'] = $product_id; // add product id into dataset for use with patterns
        
        $seo_kw = '';
        
        if (empty($value['seo_keyword']) && $this->config->get('mlseo_insertautourl')) {
          $seo_kw = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_url_pattern'), $language_id, $data);
        } else if (!empty($value['seo_keyword'])) {
          $seo_kw = html_entity_decode($value['seo_keyword'], ENT_QUOTES, 'UTF-8');
        }
        
        if ($seo_kw) {
          $seo_kw = $this->model_tool_seo_package->filter_seo($seo_kw, 'product', $product_id, $language_id);
        }
        
        if ($this->config->get('mlseo_ml_mode')) {
          $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', language_id = '" . (int)$language_id . "', keyword = '" . $this->db->escape($seo_kw) . "'");
        } else {
          $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($seo_kw) . "'");
        }
        
        if (!$value['meta_title'] && $this->config->get('mlseo_insertautoseotitle')) {
          $value['meta_title'] = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_title_pattern'), $language_id, $data);
        }
        if (!$value['meta_description'] && $this->config->get('mlseo_insertautometadesc')) {
          $value['meta_description'] = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_description_pattern'), $language_id, $data);
        }
        if (!$value['meta_keyword'] && $this->config->get('mlseo_insertautometakeyword')) {
          $value['meta_keyword'] = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_keyword_pattern'), $language_id, $data);
        }
      }
      
			
        $value['seo_h1'] = empty($value['seo_h1']) ? '' : $value['seo_h1'];
        $value['seo_h2'] = empty($value['seo_h2']) ? '' : $value['seo_h2'];
        $value['seo_h3'] = empty($value['seo_h3']) ? '' : $value['seo_h3'];
        $value['image_alt'] = empty($value['image_alt']) ? '' : $value['image_alt'];
        $value['image_title'] = empty($value['image_title']) ? '' : $value['image_title'];
      
        $extra_fields = '';
        if ($this->config->get('mlseo_enabled')) {
          $extra_fields = "seo_keyword = '" . $this->db->escape($seo_kw) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "', seo_h2 = '" . $this->db->escape($value['seo_h2']) . "', seo_h3 = '" . $this->db->escape($value['seo_h3']) . "', image_alt = '" . $this->db->escape($value['image_alt']) . "', image_title = '" . $this->db->escape($value['image_title']) . "', ";
          if (substr(VERSION, 0, 1) == 1) {
            $extra_fields .= "meta_title = '" . $this->db->escape($value['meta_title']) . "', ";
          }
        }
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET " . $extra_fields . " product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
					}
				}
			}
		}

if (isset($data['product_tab'])) {
					foreach ($data['product_tab'] as $product_tab) {
						if ($product_tab['tab_id']) {
							$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "' AND tab_id = '" . (int)$product_tab['tab_id'] . "'");

							foreach ($product_tab['product_tab_description'] as $language_id => $product_tab_description) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_tab SET product_id = '" . (int)$product_id . "', tab_id = '" . (int)$product_tab['tab_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_tab_description['text']) . "'");
							}
						}
					}
				}
		if (isset($data['product_option'])) {
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
					if (isset($product_option['product_option_value'])) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "'");

						$product_option_id = $this->db->getLastId();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int)$product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float)$product_option_value['weight'] . "', optsku= '" . $this->db->escape($product_option_value['optsku']) . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
						}
					}
				} else {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', value = '" . $this->db->escape($product_option['value']) . "', required = '" . (int)$product_option['required'] . "'");
				}
			}
		}

		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}

		if (isset($data['product_image'])) {
			foreach ($data['product_image'] as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
		}

		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}

		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}
		}

		if (isset($data['product_filter'])) {
			foreach ($data['product_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int)$product_id . "', filter_id = '" . (int)$filter_id . "'");

      // Universal Import/Export - apply filters to cateogories
        if (!empty($data['uiep_filter_to_category'])) {
          if (!empty($data['product_filter']) && !empty($data['product_category'])) {
            foreach ($data['product_category'] as $category_id) {
              foreach ($data['product_filter'] as $filter_id) {
                $this->db->query("INSERT IGNORE INTO " . DB_PREFIX . "category_filter SET category_id = '" . (int)$category_id . "', filter_id = '" . (int)$filter_id . "'");
              }
            }
          }
  			}
      
			}
		}

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

        if (isset($data['product_complect'])) {
            foreach ($data['product_complect'] as $complect_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_complect WHERE product_id = '" . (int)$product_id . "' AND complect_id = '" . (int)$complect_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_complect SET product_id = '" . (int)$product_id . "', complect_id = '" . (int)$complect_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_complect WHERE product_id = '" . (int)$complect_id . "' AND complect_id = '" . (int)$product_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_complect SET product_id = '" . (int)$complect_id . "', complect_id = '" . (int)$product_id . "'");
            }
        }

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $product_reward) {
				if ((int)$product_reward['points'] > 0) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$product_reward['points'] . "'");
				}
			}
		}

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		if (isset($data['keyword'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		if (isset($data['product_recurrings'])) {
			foreach ($data['product_recurrings'] as $recurring) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "product_recurring` SET `product_id` = " . (int)$product_id . ", customer_group_id = " . (int)$recurring['customer_group_id'] . ", `recurring_id` = " . (int)$recurring['recurring_id']);
			}
		}

		$this->cache->delete('product');

		$this->event->trigger('post.admin.product.add', $product_id);

		return $product_id;
	}

	public function editProduct($product_id, $data) {

// CostPrice
		$this->db->query("UPDATE " . DB_PREFIX . "product SET cost = '" . (float)$data['cost'] . "' WHERE product_id = '" . (int)$product_id . "'");
// CostPrice end
			
    $default_lang = $this->db->query("SELECT language_id FROM " . DB_PREFIX . "language WHERE code = '" . $this->config->get('config_language') . "'")->row['language_id'];
		$this->event->trigger('pre.admin.product.edit', $data);

		$this->db->query("UPDATE " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', location = '" . $this->db->escape($data['location']) . "', quantity = '" . (int)$data['quantity'] . "', minimum = '" . (int)$data['minimum'] . "', subtract = '" . (int)$data['subtract'] . "', stock_status_id = '" . (int)$data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', shipping = '" . (int)$data['shipping'] . "', price = '" . (float)$data['price'] . "', points = '" . (int)$data['points'] . "', weight = '" . (float)$data['weight'] . "', weight_class_id = '" . (int)$data['weight_class_id'] . "', length = '" . (float)$data['length'] . "', width = '" . (float)$data['width'] . "', height = '" . (float)$data['height'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', tax_class_id = '" . (int)$data['tax_class_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', date_modified = NOW() WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($data['image']) . "' WHERE product_id = '" . (int)$product_id . "'");
		}


      // handle batch name for universal import
      if (!empty($data['import_batch']) && defined('GKD_UNIV_IMPORT')) {
        $this->db->query("UPDATE " . DB_PREFIX . "product SET import_batch = '" . $this->db->escape($data['import_batch']) . "' WHERE product_id = '" . (int)$product_id . "'");
      }
      
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
    if ($this->config->get('mlseo_enabled'))
      $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");

		foreach ($data['product_description'] as $language_id => $value) {

      if ($this->config->get('mlseo_enabled')) {
        // cache management
        Powercache::remove('seo_rewrite.' . (int) $language_id, 'product_id=' . (int)$product_id);
        
        if ($this->config->get('mlseo_editautotitle')) {
          $value['name'] = ($value['name']) ? $value['name'] : $data['product_description'][$default_lang]['name'];
          $value['description'] = ($value['description']) ? $value['description'] : $data['product_description'][$default_lang]['description'];
        }
        
        $this->load->model('tool/seo_package');
        
        $seo_kw = '';
        
        if (empty($value['seo_keyword']) && $this->config->get('mlseo_editautourl')) {
          $seo_kw = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_url_pattern'), $language_id, $data);
        } else if (!empty($value['seo_keyword'])) {
          $seo_kw = html_entity_decode($value['seo_keyword'], ENT_QUOTES, 'UTF-8');
        }
        
        if ($seo_kw) {
          $seo_kw = $this->model_tool_seo_package->filter_seo($seo_kw, 'product', $product_id, $language_id);
        }
        
        if ($this->config->get('mlseo_ml_mode')) {
          $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', language_id = '" . (int)$language_id . "', keyword = '" . $this->db->escape($seo_kw) . "'");
        } else {
          $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($seo_kw) . "'");
        }
        
        if (!$value['meta_title'] && $this->config->get('mlseo_editautoseotitle')) {
          $value['meta_title'] = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_title_pattern'), $language_id, $data);
        }
        if (!$value['meta_description'] && $this->config->get('mlseo_editautometadesc')) {
          $value['meta_description'] = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_description_pattern'), $language_id, $data);
        }
        if (!$value['meta_keyword'] && $this->config->get('mlseo_editautometakeyword')) {
          $value['meta_keyword'] = $this->model_tool_seo_package->transformProduct($this->config->get('mlseo_product_keyword_pattern'), $language_id, $data);
        }
      }
      
			
        $value['seo_h1'] = empty($value['seo_h1']) ? '' : $value['seo_h1'];
        $value['seo_h2'] = empty($value['seo_h2']) ? '' : $value['seo_h2'];
        $value['seo_h3'] = empty($value['seo_h3']) ? '' : $value['seo_h3'];
        $value['image_alt'] = empty($value['image_alt']) ? '' : $value['image_alt'];
        $value['image_title'] = empty($value['image_title']) ? '' : $value['image_title'];
      
        $extra_fields = '';
        if ($this->config->get('mlseo_enabled')) {
          $extra_fields = "seo_keyword = '" . $this->db->escape($seo_kw) . "', seo_h1 = '" . $this->db->escape($value['seo_h1']) . "', seo_h2 = '" . $this->db->escape($value['seo_h2']) . "', seo_h3 = '" . $this->db->escape($value['seo_h3']) . "', image_alt = '" . $this->db->escape($value['image_alt']) . "', image_title = '" . $this->db->escape($value['image_title']) . "', ";
          if (substr(VERSION, 0, 1) == 1) {
            $extra_fields .= "meta_title = '" . $this->db->escape($value['meta_title']) . "', ";
          }
        }
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET " . $extra_fields . " product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_store'])) {
			foreach ($data['product_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");

		if (!empty($data['product_attribute'])) {
			foreach ($data['product_attribute'] as $product_attribute) {
				if ($product_attribute['attribute_id']) {
					foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
					}
				}
			}
		}

$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "'");

				if (!empty($data['product_tab'])) {
					foreach ($data['product_tab'] as $product_tab) {
						if ($product_tab['tab_id']) {
							$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "' AND tab_id = '" . (int)$product_tab['tab_id'] . "'");

							foreach ($product_tab['product_tab_description'] as $language_id => $product_tab_description) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_tab SET product_id = '" . (int)$product_id . "', tab_id = '" . (int)$product_tab['tab_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_tab_description['text']) . "'");
							}
						}
					}
				}
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");

if (isset($data['product_tab'])) {
					foreach ($data['product_tab'] as $product_tab) {
						if ($product_tab['tab_id']) {
							$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "' AND tab_id = '" . (int)$product_tab['tab_id'] . "'");

							foreach ($product_tab['product_tab_description'] as $language_id => $product_tab_description) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_tab SET product_id = '" . (int)$product_id . "', tab_id = '" . (int)$product_tab['tab_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_tab_description['text']) . "'");
							}
						}
					}
				}
		if (isset($data['product_option'])) {
			foreach ($data['product_option'] as $product_option) {
				if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
					if (isset($product_option['product_option_value'])) {

        $gkd_prod_opt_id = defined('GKD_UNIV_IMPORT') && !empty($product_option['product_option_id']) ? "product_option_id = '" . (int) $product_option['product_option_id'] . "'," : '';
        $gkd_prod_opt_val_id = defined('GKD_UNIV_IMPORT') && !empty($product_option['product_option_value_id']) ? "product_option_value_id = '" . (int) $product_option['product_option_value_id'] . "'," : '';
      
						$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET ".$gkd_prod_opt_id." product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "'");

						$product_option_id = $this->db->getLastId();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET ".$gkd_prod_opt_id." product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int)$product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float)$product_option_value['weight'] . "', optsku= '" . $this->db->escape($product_option_value['optsku']) . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
						}
					}
				} else {

        $gkd_prod_opt_id = defined('GKD_UNIV_IMPORT') && !empty($product_option['product_option_id']) ? "product_option_id = '" . (int) $product_option['product_option_id'] . "'," : '';
        $gkd_prod_opt_val_id = defined('GKD_UNIV_IMPORT') && !empty($product_option['product_option_value_id']) ? "product_option_value_id = '" . (int) $product_option['product_option_value_id'] . "'," : '';
      
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET ".$gkd_prod_opt_id." product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', value = '" . $this->db->escape($product_option['value']) . "', required = '" . (int)$product_option['required'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_discount'])) {
			foreach ($data['product_discount'] as $product_discount) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_special'])) {
			foreach ($data['product_special'] as $product_special) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_image'])) {
			foreach ($data['product_image'] as $product_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape($product_image['image']) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_download'])) {
			foreach ($data['product_download'] as $download_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_category'])) {
			foreach ($data['product_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_filter'])) {
			foreach ($data['product_filter'] as $filter_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int)$product_id . "', filter_id = '" . (int)$filter_id . "'");

      // Universal Import/Export - apply filters to cateogories
        if (!empty($data['uiep_filter_to_category'])) {
          if (!empty($data['product_filter']) && !empty($data['product_category'])) {
            foreach ($data['product_category'] as $category_id) {
              foreach ($data['product_filter'] as $filter_id) {
                $this->db->query("INSERT IGNORE INTO " . DB_PREFIX . "category_filter SET category_id = '" . (int)$category_id . "', filter_id = '" . (int)$filter_id . "'");
              }
            }
          }
  			}
      
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");

		if (isset($data['product_related'])) {
			foreach ($data['product_related'] as $related_id) {
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
				$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
			}
		}

        $this->db->query("DELETE FROM " . DB_PREFIX . "product_complect WHERE product_id = '" . (int)$product_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_complect WHERE complect_id = '" . (int)$product_id . "'");

        if (isset($data['product_complect'])) {
            foreach ($data['product_complect'] as $complect_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_complect WHERE product_id = '" . (int)$product_id . "' AND complect_id = '" . (int)$complect_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_complect SET product_id = '" . (int)$product_id . "', complect_id = '" . (int)$complect_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_complect WHERE product_id = '" . (int)$complect_id . "' AND complect_id = '" . (int)$product_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_complect SET product_id = '" . (int)$complect_id . "', complect_id = '" . (int)$product_id . "'");
            }
        }

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_reward'])) {
			foreach ($data['product_reward'] as $customer_group_id => $value) {
				if ((int)$value['points'] > 0) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$value['points'] . "'");
				}
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		if (isset($data['product_layout'])) {
			foreach ($data['product_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		    if (!$this->config->get('mlseo_enabled'))
          $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");

		if (!empty($data['keyword']) && !$this->config->get('mlseo_enabled')) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}

		$this->db->query("DELETE FROM `" . DB_PREFIX . "product_recurring` WHERE product_id = " . (int)$product_id);

		if (isset($data['product_recurring'])) {
			foreach ($data['product_recurring'] as $product_recurring) {
				$this->db->query("INSERT INTO `" . DB_PREFIX . "product_recurring` SET `product_id` = " . (int)$product_id . ", customer_group_id = " . (int)$product_recurring['customer_group_id'] . ", `recurring_id` = " . (int)$product_recurring['recurring_id']);
			}
		}

		$this->cache->delete('product');

		$this->event->trigger('post.admin.product.edit', $product_id);
	}

	public function copyProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		if ($query->num_rows) {
			$data = $query->row;

			$data['sku'] = '';
			$data['upc'] = '';
			$data['viewed'] = '0';
			$data['keyword'] = '';
			$data['status'] = '0';

			$data['product_attribute'] = $this->getProductAttributes($product_id);
			$data['product_description'] = $this->getProductDescriptions($product_id);
			$data['product_discount'] = $this->getProductDiscounts($product_id);
			$data['product_filter'] = $this->getProductFilters($product_id);
			$data['product_image'] = $this->getProductImages($product_id);
			$data['product_option'] = $this->getProductOptions($product_id);
			$data['product_related'] = $this->getProductRelated($product_id);
			$data['product_reward'] = $this->getProductRewards($product_id);
			$data['product_special'] = $this->getProductSpecials($product_id);
			$data['product_category'] = $this->getProductCategories($product_id);
			$data['product_download'] = $this->getProductDownloads($product_id);
			$data['product_layout'] = $this->getProductLayouts($product_id);
			$data['product_store'] = $this->getProductStores($product_id);
			$data['product_recurrings'] = $this->getRecurrings($product_id);


			$row1 = $this->getMaxModel();
			$max_mod = $row1["max(product_id)"];
			$next_code = $max_mod + 1;
			$p = strpos($data["model"], "-");
			if (!$p) strpos($data["model"], "~");
			if ($p) {
				$p = substr($data["model"], $p);
				$data["model"] = $next_code.$p;
			}
			$this->addProduct($data);
		}
	}

	public function deleteProduct($product_id) {

      Powercache::remove('seo_rewrite', 'product_id=' . (int)$product_id);
      
		$this->event->trigger('pre.admin.product.delete', $product_id);
$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "product WHERE product_id = '" . (int)$product_id . "'");

			$this->db->query("DELETE FROM " . DB_PREFIX . "question WHERE product_id = '" . (int)$product_id . "'");
			
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "'");

      // handle batch name for universal import
      if (!empty($data['import_batch']) && defined('GKD_UNIV_IMPORT')) {
        $this->db->query("UPDATE " . DB_PREFIX . "product SET import_batch = '" . $this->db->escape($data['import_batch']) . "' WHERE product_id = '" . (int)$product_id . "'");
      }
      
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_description WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "'");
$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "'");

				if (!empty($data['product_tab'])) {
					foreach ($data['product_tab'] as $product_tab) {
						if ($product_tab['tab_id']) {
							$this->db->query("DELETE FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "' AND tab_id = '" . (int)$product_tab['tab_id'] . "'");

							foreach ($product_tab['product_tab_description'] as $language_id => $product_tab_description) {
								$this->db->query("INSERT INTO " . DB_PREFIX . "product_tab SET product_id = '" . (int)$product_id . "', tab_id = '" . (int)$product_tab['tab_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_tab_description['text']) . "'");
							}
						}
					}
				}
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE related_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "review WHERE product_id = '" . (int)$product_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "product_recurring WHERE product_id = " . (int)$product_id);
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "'");

		$this->cache->delete('product');

		$this->event->trigger('post.admin.product.delete', $product_id);
	}

	public function getProduct($product_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=" . (int)$product_id . "' LIMIT 1) AS keyword FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row;
	}


	public function getMaxModel() {		
		$query = $this->db->query("SELECT max(product_id) FROM " . DB_PREFIX . "product");			
		return $query->row;
	} 
	public function getProducts($data = array()) {
		
        $sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

        # admin_product_filter
        $this->load->language('common/footer');
        if (!strripos($this->language->get('text_footer'), 'ocstore') || strripos($this->language->get('text_footer'), 'ocstore') && VERSION == '2.1.0.1') {
            if (!empty($data['filter_category'])) {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
            }
            $sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        }
        # admin_product_filter
        
        


        # admin_product_filter
        if (!strripos($this->language->get('text_footer'), 'ocstore') || strripos($this->language->get('text_footer'), 'ocstore') && VERSION == '2.1.0.1') {
            if (!empty($data['filter_category'])) {
                $sql .= " AND p2c.category_id = '" . (int)$data['filter_category'] . "'";
            }
        }
        if (isset($data['filter_manufacturer'])) {
            if (!empty($data['filter_manufacturer']) || $data['filter_manufacturer'] == '0') {
                $sql .= " AND p.manufacturer_id = '" . (int)$data['filter_manufacturer'] . "'";
            }
        }
        if (!empty($data['filter_sku'])) {
            $sql .= " AND p.sku LIKE '%" . $this->db->escape($data['filter_sku']) . "%'";
        }
        # admin_product_filter
        

    if (!empty($data['filter_import_batch'])) {
			$sql .= " AND p.import_batch = '" . $this->db->escape($data['filter_import_batch']) . "'";
		}
      
		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE  '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}


// CostPrice
		if (isset($data['filter_cost']) && !is_null($data['filter_cost'])) {
			$sql .= " AND p.cost LIKE '" . $this->db->escape($data['filter_cost']) . "%'";
		}
// CostPrice end
			
		if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . (int)$data['filter_quantity'] . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}
		
		$sql .= " GROUP BY p.product_id";

		$sort_data = array(
			'pd.name',
			'p.model',
			'p.price',

// CostPrice
			'p.cost',
// CostPrice end
			
			'p.quantity',
			'p.status',
			'p.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY pd.name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getProductsByCategoryId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p2c.category_id = '" . (int)$category_id . "' ORDER BY pd.name ASC");

		return $query->rows;
	}

	public function getProductDescriptions($product_id) {
		$product_description_data = array();

		
      $extra_select = '';
      
      if ($this->config->get('mlseo_enabled')) {
        if ($this->config->get('mlseo_ml_mode')) {
          $extra_select = ",(SELECT keyword FROM " . DB_PREFIX . "url_alias u WHERE query = 'product_id=".$product_id."' AND u.language_id = d.language_id LIMIT 1) AS seo_keyword";
        } else {
          $extra_select = ",(SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'product_id=".$product_id."' LIMIT 1) AS seo_keyword";
        }
      }
      
      $query = $this->db->query("SELECT * ".$extra_select." FROM " . DB_PREFIX . "product_description d WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_description_data[$result['language_id']] = array(
				'name'             => $result['name'],
        'seo_keyword'     => isset($result['seo_keyword']) ? $result['seo_keyword'] : '',
        'seo_h1'       => isset($result['seo_h1']) ? $result['seo_h1'] : '',
        'seo_h2'       => isset($result['seo_h2']) ? $result['seo_h2'] : '',
        'seo_h3'       => isset($result['seo_h3']) ? $result['seo_h3'] : '',
        'image_alt'       => isset($result['image_alt']) ? $result['image_alt'] : '',
        'image_title'       => isset($result['image_title']) ? $result['image_title'] : '',
				'description'      => $result['description'],
				'meta_title'       => $result['meta_title'],
				'meta_description' => $result['meta_description'],
				'meta_keyword'     => $result['meta_keyword'],
				'tag'              => $result['tag']
			);
		}

		return $product_description_data;
	}

	public function getProductCategories($product_id) {
		$product_category_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_category_data[] = $result['category_id'];
		}

		return $product_category_data;
	}

	public function getProductFilters($product_id) {
		$product_filter_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_filter WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_filter_data[] = $result['filter_id'];
		}

		return $product_filter_data;
	}

	public function getProductAttributes($product_id) {
		$product_attribute_data = array();

		$product_attribute_query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' GROUP BY attribute_id");

		foreach ($product_attribute_query->rows as $product_attribute) {
			$product_attribute_description_data = array();

			$product_attribute_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");

			foreach ($product_attribute_description_query->rows as $product_attribute_description) {
				$product_attribute_description_data[$product_attribute_description['language_id']] = array('text' => $product_attribute_description['text']);
			}

			$product_attribute_data[] = array(
				'attribute_id'                  => $product_attribute['attribute_id'],
				'product_attribute_description' => $product_attribute_description_data
			);
		}

		return $product_attribute_data;
	}

	public function getProductOptions($product_id) {
		$product_option_data = array();

		$product_option_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_option` po LEFT JOIN `" . DB_PREFIX . "option` o ON (po.option_id = o.option_id) LEFT JOIN `" . DB_PREFIX . "option_description` od ON (o.option_id = od.option_id) WHERE po.product_id = '" . (int)$product_id . "' AND od.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		foreach ($product_option_query->rows as $product_option) {
			$product_option_value_data = array();

			$product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int)$product_option['product_option_id'] . "'");

			foreach ($product_option_value_query->rows as $product_option_value) {
				$product_option_value_data[] = array(
					'product_option_value_id' => $product_option_value['product_option_value_id'],
					'option_value_id'         => $product_option_value['option_value_id'],
					'quantity'                => $product_option_value['quantity'],
					'subtract'                => $product_option_value['subtract'],
					'price'                   => $product_option_value['price'],
					'price_prefix'            => $product_option_value['price_prefix'],
					'points'                  => $product_option_value['points'],
					'points_prefix'           => $product_option_value['points_prefix'],
					'weight'                  => $product_option_value['weight'],
					'optsku'          		  => $product_option_value['optsku'],
					'weight_prefix'           => $product_option_value['weight_prefix']
				);
			}

			$product_option_data[] = array(
				'product_option_id'    => $product_option['product_option_id'],
				'product_option_value' => $product_option_value_data,
				'option_id'            => $product_option['option_id'],
				'name'                 => $product_option['name'],
				'type'                 => $product_option['type'],
				'value'                => $product_option['value'],
				'required'             => $product_option['required']
			);
		}

		return $product_option_data;
	}

	public function getProductImages($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_image WHERE product_id = '" . (int)$product_id . "' ORDER BY sort_order ASC");

		return $query->rows;
	}

	public function getProductDiscounts($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_discount WHERE product_id = '" . (int)$product_id . "' ORDER BY quantity, priority, price");

		return $query->rows;
	}

	public function getProductSpecials($product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id . "' ORDER BY priority, price");

		return $query->rows;
	}

	public function getProductRewards($product_id) {
		$product_reward_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_reward WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_reward_data[$result['customer_group_id']] = array('points' => $result['points']);
		}

		return $product_reward_data;
	}

	public function getProductDownloads($product_id) {
		$product_download_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_download WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_download_data[] = $result['download_id'];
		}

		return $product_download_data;
	}

	public function getProductStores($product_id) {
		$product_store_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_store WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_store_data[] = $result['store_id'];
		}

		return $product_store_data;
	}

	public function getProductLayouts($product_id) {
		$product_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_to_layout WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_layout_data[$result['store_id']] = $result['layout_id'];
		}

		return $product_layout_data;
	}

	public function getProductRelated($product_id) {
		$product_related_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $result) {
			$product_related_data[] = $result['related_id'];
		}

		return $product_related_data;
	}

    public function getProductComplect($product_id) {
        $product_complect_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_complect WHERE product_id = '" . (int)$product_id . "'");

        foreach ($query->rows as $result) {
            $product_complect_data[] = $result['complect_id'];
        }

        return $product_complect_data;
    }

	public function getRecurrings($product_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "product_recurring` WHERE product_id = '" . (int)$product_id . "'");

		return $query->rows;
	}

	public function getTotalProducts($data = array()) {
		$sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";

        # admin_product_filter
        $this->load->language('common/footer');
        if (!strripos($this->language->get('text_footer'), 'ocstore') || strripos($this->language->get('text_footer'), 'ocstore') && VERSION == '2.1.0.1') {
            if (!empty($data['filter_category'])) {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
            }
        }
        # admin_product_filter
        

		$sql .= " WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";


        # admin_product_filter
        if (!strripos($this->language->get('text_footer'), 'ocstore') || strripos($this->language->get('text_footer'), 'ocstore') && VERSION == '2.1.0.1') {
            if (!empty($data['filter_category'])) {
                $sql .= " AND p2c.category_id = '" . (int)$data['filter_category'] . "'";
            }
        }
        if (isset($data['filter_manufacturer'])) {
            if (!empty($data['filter_manufacturer']) || $data['filter_manufacturer'] == '0') {
                $sql .= " AND p.manufacturer_id = '" . (int)$data['filter_manufacturer'] . "'";
            }
        }
        if (!empty($data['filter_sku'])) {
            $sql .= " AND p.sku LIKE '%" . $this->db->escape($data['filter_sku']) . "%'";
        }
        # admin_product_filter
        

    if (!empty($data['filter_import_batch'])) {
			$sql .= " AND p.import_batch = '" . $this->db->escape($data['filter_import_batch']) . "'";
		}
      
		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}


// CostPrice
		if (isset($data['filter_cost']) && !is_null($data['filter_cost'])) {
			$sql .= " AND p.cost LIKE '" . $this->db->escape($data['filter_cost']) . "%'";
		}
// CostPrice end
			
		if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . (int)$data['filter_quantity'] . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalProductsByTaxClassId($tax_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE tax_class_id = '" . (int)$tax_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByStockStatusId($stock_status_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE stock_status_id = '" . (int)$stock_status_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByWeightClassId($weight_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE weight_class_id = '" . (int)$weight_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByLengthClassId($length_class_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE length_class_id = '" . (int)$length_class_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByDownloadId($download_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_download WHERE download_id = '" . (int)$download_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByManufacturerId($manufacturer_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product WHERE manufacturer_id = '" . (int)$manufacturer_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByAttributeId($attribute_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_attribute WHERE attribute_id = '" . (int)$attribute_id . "'");

		return $query->row['total'];
	}

public function getTotalProductsByTabId($tab_id) {
					$query = $this->db->query("SELECT COUNT(DISTINCT product_id) AS total FROM " . DB_PREFIX . "product_tab WHERE tab_id = '" . (int)$tab_id . "'");

					return $query->row['total'];
				}
	public function getTotalProductsByOptionId($option_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_option WHERE option_id = '" . (int)$option_id . "'");

		return $query->row['total'];
	}

	public function getTotalProductsByProfileId($recurring_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_recurring WHERE recurring_id = '" . (int)$recurring_id . "'");

		return $query->row['total'];
	}

public function getProductTabs($product_id) {

					$product_tab_data = array();

					$product_tab_query = $this->db->query("SELECT t.tab_id, td.name FROM " . DB_PREFIX . "product_tab pt LEFT JOIN " . DB_PREFIX . "tab t ON (pt.tab_id = t.tab_id) LEFT JOIN " . DB_PREFIX . "tab_description td ON (t.tab_id = td.tab_id) WHERE pt.product_id = '" . (int)$product_id . "' AND td.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY pt.tab_id");

					foreach ($product_tab_query->rows as $product_tab) {

						$product_tab_description_data = array();

						$product_tab_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_tab WHERE product_id = '" . (int)$product_id . "' AND tab_id = '" . (int)$product_tab['tab_id'] . "'");

						foreach ($product_tab_description_query->rows as $product_tab_description) {
							$product_tab_description_data[$product_tab_description['language_id']] = array('text' => $product_tab_description['text']);
						}

						$product_tab_data[] = array(
							'tab_id' 									=> $product_tab['tab_id'],
							'name'         						=> $product_tab['name'],
							'product_tab_description' => $product_tab_description_data
						);

					}
					return $product_tab_data;
				}
	public function getTotalProductsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "product_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}
