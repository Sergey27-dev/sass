<?php 
class ControllerCommonHeaderLogin extends Controller {
	public function index() {
		
		$data['cosyone_header_login'] = $this->config->get('cosyone_header_login');
		$this->load->language('account/login');
		
		$data['text_login'] = $this->language->get('text_login');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		
		$data['button_login'] = $this->language->get('button_login');
		$data['text_new_customer'] = $this->language->get('text_new_customer');
		$data['text_register'] = $this->language->get('text_register');

		$data['config_soc_vk'] = $this->config->get('config_soc_vk');
		$data['config_soc_inst'] = $this->config->get('config_soc_inst');
			

		$this->language->load('module/account');
		$data['text_logout'] = $this->language->get('text_logout');
		
		$this->load->model('account/customer');

			if (isset($this->request->get['route'])){
			$data['router'] = $this->request->get;
		}
		$data['action'] = $this->url->link('account/login', '', 'SSL');
		$data['logout_link'] = $this->url->link('account/logout', '', 'SSL');
		$data['login_link'] = $this->url->link('account/login', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
		
		$data['logged'] = $this->customer->isLogged();
		
		// Added strpos check to pass McAfee PCI compliance test (http://forum.opencart.com/viewtopic.php?f=10&t=12043&p=151494#p151295)
		if (isset($this->request->post['redirect']) && (strpos($this->request->post['redirect'], $this->config->get('config_url')) !== false || strpos($this->request->post['redirect'], $this->config->get('config_ssl')) !== false)) {
			$data['redirect'] = $this->request->post['redirect'];
		} elseif (isset($this->session->data['redirect'])) {
			$data['redirect'] = $this->session->data['redirect'];

			unset($this->session->data['redirect']);		  	
		} else {
			$data['redirect'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['password'])) {
			$data['password'] = $this->request->post['password'];
		} else {
			$data['password'] = '';
		}
		
		return $this->load->view('cosyone/template/common/header_login.tpl', $data);
	}
	public function info() {
		$this->response->setOutput($this->index());
	}
}