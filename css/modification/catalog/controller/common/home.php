<?php
require_once DIR_SYSTEM.'library/'.'Mobile_Detect.php';

class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));

  // seo meta (overwrites the previously defined)
  if ($this->config->get('mlseo_enabled')) {
    $seo_meta = $this->config->get('mlseo_store');
    if (isset($seo_meta[$this->config->get('config_store_id').$this->config->get('config_language_id')])) {
      $seo_meta = $seo_meta[$this->config->get('config_store_id').$this->config->get('config_language_id')];
    }
    
    if (!empty($seo_meta['seo_title'])) {
      ${'this'}->document->setTitle($seo_meta['seo_title']);
    } else {
      ${'this'}->document->setTitle($this->config->get('config_title'));
    }
    
    if (!empty($seo_meta['description'])) {
      ${'this'}->document->setDescription($seo_meta['description']);
    } else {
      ${'this'}->document->setDescription($this->config->get('config_meta_description'));
    }
    
    if (!empty($seo_meta['keywords'])) {
      ${'this'}->document->setKeywords($seo_meta['keywords']);
    }
    
    if (substr(VERSION, 0, 1) == 2) {
      $data['heading_title'] = $data['seo_h1'] = !empty($seo_meta['title']) ? $seo_meta['title'] : $this->config->get('config_title');
      $data['seo_h2'] = !empty($seo_meta['h2']) ? $seo_meta['h2'] : '';
      $data['seo_h3'] = !empty($seo_meta['h3']) ? $seo_meta['h3'] : '';
    } else {
      $this->data['heading_title'] = $this->data['seo_h1'] = !empty($seo_meta['title']) ? $seo_meta['title'] : $this->config->get('config_title');
      $this->data['seo_h2'] = !empty($seo_meta['h2']) ? $seo_meta['h2'] : '';
      $this->data['seo_h3'] = !empty($seo_meta['h3']) ? $seo_meta['h3'] : '';
    }
  }
  /* now defined in header ctrl
  $this->load->model('tool/seo_package');
  
  if ($this->config->get('mlseo_opengraph')) {
    if (substr(VERSION, 0, 1) == 2) {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('opengraph', 'home'));
    } else {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('opengraph', 'home'));
    }
  }
  
  if ($this->config->get('mlseo_tcard')) {
    if (substr(VERSION, 0, 1) == 2) {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('tcard', 'home'));
    } else {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('tcard', 'home'));
    }
  }
  
  if ($this->config->get('mlseo_gpublisher')) {
    if (substr(VERSION, 0, 1) == 2) {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('gpublisher', 'home'));
    } else {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('gpublisher', 'home'));
    }
  }
  */
  // end - seo meta
      

		//Блог
		if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog.css');
		}
		
    	$this->language->load('blog/blog');
		
		$this->load->model('blog/blog');	
		
		$this->load->model('tool/image');

        $this->load->model('catalog/category');
		
		// Fall back values
		$limit = $this->config->get('blogsetting_blogs_per_page');
		if (empty($limit)) {
		$limit = 5;
		}
		
		$img_width = $this->config->get('blogsetting_thumbs_w');
		if (empty($img_width)) {
		$img_width = 848;
		}
		
		$img_height = $this->config->get('blogsetting_thumbs_h');
		if (empty($img_height)) {
		$img_height = 424;
		}
		
		$data['date_added_status'] = $this->config->get('blogsetting_date_added');
		if (empty($data['date_added_status'])) {
		$data['date_added_status'] = 0;
		}
		
		$data['comments_count_status'] = $this->config->get('blogsetting_comments_count');
		if (empty($data['comments_count_status'])) {
		$data['comments_count_status'] = 0;
		}
		
		$data['page_view_status'] = $this->config->get('blogsetting_page_view');
		if (empty($data['page_view_status'])) {
		$data['page_view_status'] = 0;
		}
		
		$data['author_status'] = $this->config->get('blogsetting_author');
		if (empty($data['blogsetting_author'])) {
		$data['author_status'] = 0;
		}
		
		$data['list_columns'] = $this->config->get('blogsetting_layout');
		if (empty($data['list_columns'])) {
		$data['list_columns'] = 0;
		}
		
		$data['breadcrumbs'] = array();

      	$data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home')
      	);

      	$data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_blog'),
			'href'      => $this->url->link('blog/home')
      	);	
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$pagefix = ($page - 1) * $limit;
			
		if ($pagefix < 1) { $pagefix = 0;}
		
		if( isset($this->request->get['tag']) ){
				$filter_tag = $this->request->get['tag'];
		}else {
				$filter_tag = '';
		}
		
		$data['blogs'] = array();

		$filter_data = array(
			'start' => ($page - 1) * $limit,
			'limit' => $limit,
			'filter_tag'  => $filter_tag,
		);
		
		
		$blog_total = $this->model_blog_blog->getTotalBlogs($filter_data);
		
		$results = $this->model_blog_blog->getBlogs($filter_data, $pagefix, $limit);
 
    	foreach ($results as $result) {
    		$alias = $this->model_blog_blog->getBlogIdAlias($result['blog_id']);

    		if(!empty($alias['keyword'])){
    			$href = $this->url->link('blog/blog').'/'.$alias['keyword'];
    		} else {
    			$href = $this->url->link('blog/blog', 'blog_id=' . $result['blog_id']);
    		}
						
			$data['blogs'][] = array(
			'count_read' => $result['count_read'],
			'comment_total' => $this->model_blog_blog->getTotalCommentsByBlogId($result['blog_id']),
			'blog_id' => $result['blog_id'],
			'title'      => $result['title'],
			'short_description'      => html_entity_decode($result['short_description'], ENT_QUOTES, 'UTF-8'),
			'date_added_full' => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
			'author' => $result['author'],
			'image'   		=> $this->model_tool_image->resize($result['image'], $img_width, $img_height),
			'href' => $href 
			);
		}


        $data['categories'] = array();
    	$category_id = 59;
    	$results = $this->model_catalog_category->getCategories($category_id);



        foreach ($results as $result) {
            $filter_data = array(
                'filter_category_id'  => $result['category_id'],
                'filter_sub_category' => true
            );
            $image = $this->model_tool_image->resize($result['image'], $this->config->get('cosyone_refine_image_w'), $this->config->get('cosyone_refine_image_h'));
            $data['categories'][] = array(

                'thumb' => $image,

                'name'  => $result['name'],
                'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '_' . $result['category_id'])
            );

        }
		
		// Home page title
		$blog_page_title = $this->config->get('blogsetting_home_page_title');
		if (!empty($blog_page_title[$this->config->get('config_language_id')])) {
		$this->document->setTitle($blog_page_title[$this->config->get('config_language_id')]);
		} else {
		$this->document->setTitle($this->language->get('text_blog'));
		}
		
		// Home title
		$blog_title = $this->config->get('blogsetting_home_title');
		if (!empty($blog_title[$this->config->get('config_language_id')])) {
		$data['heading_title'] = $blog_title[$this->config->get('config_language_id')];
		} else {
		$data['heading_title'] = $this->language->get('text_blog');
		}
        
		// Home description
		$blog_description = $this->config->get('blogsetting_home_description');
		if (empty($blog_description[$this->config->get('config_language_id')]) || ($blog_description[$this->config->get('config_language_id')] == '&lt;p&gt;&lt;br&gt;&lt;/p&gt;')) {
		$data['description'] = false;
		} else {
		$data['description'] = html_entity_decode(($blog_description[$this->config->get('config_language_id')]), ENT_QUOTES, 'UTF-8');
		}
		
		// If searched on a blog tag
		if($filter_tag){
		$data['heading_title'] = $this->language->get('text_filter_by') . $filter_tag;
		$this->document->setTitle($this->language->get('text_filter_by') . $filter_tag);
		$data['description'] = false;
		}
					
		$blog_page_meta_description = $this->config->get('blogsetting_home_meta_description');
		if ($blog_page_meta_description[$this->config->get('config_language_id')]) {
		$this->document->setDescription($blog_page_meta_description[$this->config->get('config_language_id')]);
		}

  // seo meta (overwrites the previously defined)
  if ($this->config->get('mlseo_enabled')) {
    $seo_meta = $this->config->get('mlseo_store');
    if (isset($seo_meta[$this->config->get('config_store_id').$this->config->get('config_language_id')])) {
      $seo_meta = $seo_meta[$this->config->get('config_store_id').$this->config->get('config_language_id')];
    }
    
    if (!empty($seo_meta['seo_title'])) {
      ${'this'}->document->setTitle($seo_meta['seo_title']);
    } else {
      ${'this'}->document->setTitle($this->config->get('config_title'));
    }
    
    if (!empty($seo_meta['description'])) {
      ${'this'}->document->setDescription($seo_meta['description']);
    } else {
      ${'this'}->document->setDescription($this->config->get('config_meta_description'));
    }
    
    if (!empty($seo_meta['keywords'])) {
      ${'this'}->document->setKeywords($seo_meta['keywords']);
    }
    
    if (substr(VERSION, 0, 1) == 2) {
      $data['heading_title'] = $data['seo_h1'] = !empty($seo_meta['title']) ? $seo_meta['title'] : $this->config->get('config_title');
      $data['seo_h2'] = !empty($seo_meta['h2']) ? $seo_meta['h2'] : '';
      $data['seo_h3'] = !empty($seo_meta['h3']) ? $seo_meta['h3'] : '';
    } else {
      $this->data['heading_title'] = $this->data['seo_h1'] = !empty($seo_meta['title']) ? $seo_meta['title'] : $this->config->get('config_title');
      $this->data['seo_h2'] = !empty($seo_meta['h2']) ? $seo_meta['h2'] : '';
      $this->data['seo_h3'] = !empty($seo_meta['h3']) ? $seo_meta['h3'] : '';
    }
  }
  /* now defined in header ctrl
  $this->load->model('tool/seo_package');
  
  if ($this->config->get('mlseo_opengraph')) {
    if (substr(VERSION, 0, 1) == 2) {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('opengraph', 'home'));
    } else {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('opengraph', 'home'));
    }
  }
  
  if ($this->config->get('mlseo_tcard')) {
    if (substr(VERSION, 0, 1) == 2) {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('tcard', 'home'));
    } else {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('tcard', 'home'));
    }
  }
  
  if ($this->config->get('mlseo_gpublisher')) {
    if (substr(VERSION, 0, 1) == 2) {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('gpublisher', 'home'));
    } else {
      $this->document->addSeoMeta($this->model_tool_seo_package->rich_snippet('gpublisher', 'home'));
    }
  }
  */
  // end - seo meta
      
		
		$blog_page_meta_keyword = $this->config->get('blogsetting_home_meta_keyword');
		if ($blog_page_meta_keyword[$this->config->get('config_language_id')]) {
		$this->document->setKeywords($blog_page_meta_keyword[$this->config->get('config_language_id')]);
		}

		$data['text_posted_on'] = $this->language->get('text_posted_on');
		$data['text_read'] = $this->language->get('text_read');
		$data['text_posted_by'] = $this->language->get('text_posted_by');
		$data['text_comments'] = $this->language->get('text_comments');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_read_more'] = $this->language->get('text_read_more');
		
		$url = '';
		
		/*if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}*/
		
		if( isset($this->request->get['tag']) ){
			$url .= '&tag=' . $filter_tag;
		}
		
		$pagination = new Pagination();
		$pagination->total = $blog_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('blogsetting_blogs_per_page');
		if (empty($pagination->limit)) {$pagination->limit = 5;}
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('blog/home', $url . '&page={page}');
		
		$data['pagination'] = $pagination->render();
		
		$data['results'] = sprintf($this->language->get('text_pagination'), ($blog_total) ? ($pagefix) + 1 : 0, ((($page - 1) * $limit) > ($blog_total - $limit)) ? $blog_total : (($pagefix) + $limit), $blog_total, ceil($blog_total / $limit));
			

			$data['home_top_top'] = $this->load->controller('common/home_top_top');
			$data['home_top_left'] = $this->load->controller('common/home_top_left');
			$data['home_top_center'] = $this->load->controller('common/home_top_center');
			$data['home_top_right'] = $this->load->controller('common/home_top_right');
			$data['content_bottom_half'] = $this->load->controller('common/content_bottom_half');
			// Cosyone ends
		

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
			
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		
		if ((float)VERSION >= 2.2) {
				$this->response->setOutput($this->load->view('blog/blog_home', $data));
			} else {
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/blog/blog_home.tpl')) {
					$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/blog/blog_home.tpl', $data));
				} else {
					$this->response->setOutput($this->load->view('default/template/blog/blog_home.tpl', $data));
				}
			}
		

		//КонецБлог



		if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}

			if(isset($this->session->data['cat'])){
			unset($this->session->data['cat']);
		}


			$data['home_top_top'] = $this->load->controller('common/home_top_top');
			$data['home_top_left'] = $this->load->controller('common/home_top_left');
			$data['home_top_center'] = $this->load->controller('common/home_top_center');
			$data['home_top_right'] = $this->load->controller('common/home_top_right');
			$data['content_bottom_half'] = $this->load->controller('common/content_bottom_half');
			// Cosyone ends
		

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
			
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

        static $module = 0;

        $this->load->model('design/banner');
        $this->load->model('tool/image');

        $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
        $this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.transitions.css');
        $this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

        $data['banners'] = array();

        $results = $this->model_design_banner->getBanner(9);

        foreach ($results as $result) {
            if (is_file(DIR_IMAGE . $result['image'])) {
                $data['banners'][] = array(
                    'title' => $result['title'],
                    'link'  => $result['link'],
                    'image' => $result['image']
                );
            }
        }

		$detect = new Mobile_Detect;

		if( $detect->isMobile() && !$detect->isTablet() ){
			$data['mobile'] = 1;
		} else {
			$data['mobile'] = 0;
		}
		if ($detect->isTablet()){
			$data['tablet'] = 1;
		} else {
			$data['tablet'] = 0;
		}

		$data['banners_mobile'] = array();

        $results = $this->model_design_banner->getBanner(10);

        foreach ($results as $result) {
            if (is_file(DIR_IMAGE . $result['image'])) {
                $data['banners_mobile'][] = array(
                    'title' => $result['title'],
                    'link'  => $result['link'],
                    'image' => $result['image']
                );
            }
        }

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/home.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
		}
	}
}