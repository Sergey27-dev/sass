<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

        $data['logo'] = $this->config->get('config_logo');
		$data['home'] = $this->url->link('common/home');
		$data['store'] = $this->config->get('config_name');
		$data['address'] = nl2br($this->config->get('config_address'));
		$data['geocode'] = $this->config->get('config_geocode');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['fax'] = $this->config->get('config_fax');
		$data['comment'] = $this->config->get('config_comment');
		$data['open'] = nl2br($this->config->get('config_open'));
		$data['email'] = nl2br($this->config->get('config_email'));
		$data['vk_link'] = $this->config->get('config_soc_vk');
		$data['inst_link'] = $this->config->get('config_soc_inst');
		$data['privacy_link'] = $this->url->link('information/information','information_id='.$this->config->get('config_privacy'));
			
		if (isset($this->request->get['route'])){
			$data['router'] = $this->request->get;
		}

		$this->load->model('catalog/information');

			$data['live_search'] = $this->load->controller('module/d_ajax_search');
			$data['footer_modules'] = $this->load->controller('common/footer_modules');
			$cosyone_footer_block_title = $this->config->get('cosyone_footer_custom_block_title');
			if(empty($cosyone_footer_block_title[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block_title'] = false;
			} else if (isset($cosyone_footer_block_title[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block_title'] = html_entity_decode($cosyone_footer_block_title[$this->language->get('code')], ENT_QUOTES, 'UTF-8');
			}
			$data['cosyone_footer_payment_icon'] = $this->config->get('cosyone_footer_payment_icon');
			$data['cosyone_use_retina'] = $this->config->get('cosyone_use_retina');
			$cosyone_footer_block = $this->config->get('cosyone_footer_custom_block');
			if(empty($cosyone_footer_block[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block'] = false;
			} else if (isset($cosyone_footer_block[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block'] = html_entity_decode($cosyone_footer_block[$this->language->get('code')], ENT_QUOTES, 'UTF-8');
			}
			

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		// Custom categories starts
		// Add current class for active categories
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if (isset($parts[0])) {
			$data['category_1_id'] = $parts[0];
		} else {
			$data['category_1_id'] = 0;
		}
		
		$categories_1 = $this->model_catalog_category->getCategories(0);
		$this->load->model('tool/image');
		foreach ($categories_1 as $category_1) {
			if ($category_1['top']) {
				$level_2_data = array();
				$categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
				foreach ($categories_2 as $category_2) {
					$level_3_data = array();

				// Third level
					$categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);

					foreach ($categories_3 as $category_3) {
						$level_3_data[] = array(
							'name' => $category_3['name'],
							'href' => $this->url->link('product/category', 'path=' . $category_1['category_id'] . '_' . $category_2['category_id'] . '_' . $category_3['category_id'])
						);
					} 
					
				// Second level
					$categories_2 = $this->model_catalog_category->getCategories(0);

					if ($category_2['image']) {
						//$category_2_image = $this->model_tool_image->resize($category_2['image'], $this->config->get('cosyone_menu_mega_second_image_w'), $this->config->get('cosyone_menu_mega_second_image_h'));
						$category_2_image = $this->model_tool_image->resize($category_2['image'], 18, 18);
					} else {
						$category_2_image = '';
					}
					$level_2_data[] = array(
						'name'    	=> $category_2['name'],
						'thumb' 	=> $category_2_image,
						'children'	=> $level_3_data,
						'href'    	=> $this->url->link('product/category', 'path=' . $category_1['category_id'] . '_' . $category_2['category_id'])
					);					
				}
				
				// First level
				$data['categories'][] = array(
					'category_1_id' => $category_1['category_id'],
					'column'   => $category_1['column'] ? $category_1['column'] : 1,
					'name'     => $category_1['name'],
					'children' => $level_2_data,
					'href'     => $this->url->link('product/category', 'path=' . $category_1['category_id'])
				);
			}
		}
	// Custom categories ends

		$this->load->model('blog/blog_category');
		
		$this->load->model('blog/blog');

		$data['blog_categories'] = array();

		$blog_categories = $this->model_blog_blog_category->getBlogCategories();

		foreach ($blog_categories as $blog_category) {
			$alias = $this->model_blog_blog_category->getBlogAlias($blog_category['blog_category_id']);
			if($blog_category['menu'] == 1){
				$data['blog_categories'][] = array(
					'name'     => $blog_category['name'],
					'href'     => $this->url->link('blog/category', 'blogpath=' . $blog_category['blog_category_id']),
					'url_link'=>$alias['keyword']
				);
			}
		}

		$this->load->model('catalog/information');

			$data['live_search'] = $this->load->controller('module/d_ajax_search');
			$data['footer_modules'] = $this->load->controller('common/footer_modules');
			$cosyone_footer_block_title = $this->config->get('cosyone_footer_custom_block_title');
			if(empty($cosyone_footer_block_title[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block_title'] = false;
			} else if (isset($cosyone_footer_block_title[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block_title'] = html_entity_decode($cosyone_footer_block_title[$this->language->get('code')], ENT_QUOTES, 'UTF-8');
			}
			$data['cosyone_footer_payment_icon'] = $this->config->get('cosyone_footer_payment_icon');
			$data['cosyone_use_retina'] = $this->config->get('cosyone_use_retina');
			$cosyone_footer_block = $this->config->get('cosyone_footer_custom_block');
			if(empty($cosyone_footer_block[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block'] = false;
			} else if (isset($cosyone_footer_block[$this->language->get('code')])) {
				$data['cosyone_footer_custom_block'] = html_entity_decode($cosyone_footer_block[$this->language->get('code')], ENT_QUOTES, 'UTF-8');
			}
			

		$data['informations'] = array();

		$informations = $this->model_catalog_information->getInformations();

		foreach ($informations as $information) {
			$alias = $this->model_catalog_information->getInformationAlias($information['information_id']);
			if($information['menu'] == 1){
				$data['informations'][] = array(
					'title'     => $information['title'],
					'href'     => $this->url->link('information/information', 'information_id=' .  $information['information_id']),
					'url_link'=>$information['seo_keyword']
				);
			}
		}
		$this->load->model('gallery/album');

		$data['galls'] = array();

		$galls = $this->model_gallery_album->getCatAlbums();

		foreach ($galls as $gall) {
			if($gall['menu'] == 1){
				$data['galls'][] = array(
					'name'     => $gall['name'],
					'href'     => $this->url->link('gallery/album', 'album_id=' .  $gall['album_id'])
				);
			}
		}

		$data['home'] = $this->url->link('common/home');

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', 'SSL');
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
		$data['telephone'] = $this->config->get('config_telephone');
		$data['email'] = $this->config->get('config_email');
		$data['fax'] = $this->config->get('config_fax');
		$data['address'] = $this->config->get('config_address');

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}
}