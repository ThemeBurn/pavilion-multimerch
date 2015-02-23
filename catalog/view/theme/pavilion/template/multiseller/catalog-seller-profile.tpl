<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('seller/catalog-seller/profile.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('seller/catalog-seller/profile.page_title'); ?>
<h1 ><?php echo $seller['nickname']; ?></h1 >
<?php $tbData->slotStop(); ?>

<?php // Product listing ---------------------------------------------- ?>

<?php TB_StaticThemeManager::get()->getThemeExtension()->getPlugin('product')->filterOcModuleProducts(new sfEvent($this, 'dummy'), array('products' => &$seller['products'])); ?>
<?php $tbData->slotStartSystem('seller/catalog-seller/profile.page_content'); ?>
<div class="ms-catalog-seller-profile">
  <div class="seller-data row tb_sep">
    <div class="col-md-9 col-xs-12">
      <?php if ($this->config->get('msconf_enable_seller_banner') && isset($seller['banner'])) { ?>
      <ul class="thumbnails seller-banner">
        <li><a class="thumbnail"><img src="<?php echo $seller['banner']; ?>" title="<?php echo $seller['nickname']; ?>" alt="<?php echo $seller['nickname']; ?>" /></a></li>
      </ul>
      <?php } ?>
      <div class="seller-description"><?php echo $seller['description']; ?></div>
    </div>
    <div class="col-md-3 col-xs-12">
      <div class="info-box">
        <a class="avatar-box" href="<?php echo $seller['href']; ?>"><img src="<?php echo $seller['thumb']; ?>" /></a>
        <span class="clear"></span>
        <h3 class="left"><?php echo $seller['nickname']; ?></h3>
        <?php if (isset($seller['country']) && $seller['country']) { ?>
        <p class="country">(<?php echo $seller['country']; ?>)</p>
        <?php } ?>
        <span class="clear"></span>
        <dl>
          <?php if (isset($seller['company']) && $seller['company']) { ?>
          <dt><?php echo $ms_catalog_seller_profile_company; ?></dt>
          <dd><?php echo $seller['company']; ?></dd>
          <?php } ?>
          <?php if ($seller['website']) { ?>
          <dt><?php echo $ms_catalog_seller_profile_website; ?></dt>
          <dd><?php echo $seller['website']; ?></dd>
          <?php } ?>
          <dt><?php echo $ms_catalog_seller_profile_totalsales; ?></dt>
          <dd><?php echo $seller['total_sales']; ?></dd>
          <dt><?php echo $ms_catalog_seller_profile_totalproducts; ?></dt>
          <dd><?php echo $seller['total_products']; ?></dd>
        </dl>
        <a href="<?php echo $seller['href']; ?>" class="tb_button tb_h_24"><span><?php echo $ms_catalog_seller_profile_view_products; ?></span></a>
      </div>

      <?php if ($this->config->get('mmess_conf_enable') || $this->config->get('msconf_enable_private_messaging') == 2) { ?>
      <?php if ((!$this->customer->getId()) || ($this->customer->getId() != $seller['seller_id'])) { ?>
      <span class="clear tb_border_str_1 tb_mb_20 tb_pt_20"></span>

      <?php echo $contactForm; ?>

      <div class="contact">
        <h3><?php echo $ms_sellercontact_title ?></h3>
        <?php if ($this->customer->getId()) { ?>
          <div class="button-group">
          <button type="button" class="tb_button tb_h_24 ms-sellercontact" data-toggle="modal" data-target="#contactDialog"><span><?php echo $ms_catalog_product_contact; ?></span></button>
          </div>
        <?php } else { ?>
          <?php echo sprintf($this->language->get('ms_sellercontact_signin'), $this->url->link('account/login', '', 'SSL'), $seller['nickname']); ?>
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
    </div>
  </div>

  <?php if ($seller['products']) { ?>
  <span class="clear tb_border_str_2 tb_sep"></span>

  <h2><?php echo $ms_catalog_seller_profile_products; ?></h2>
  <div class="tb_products tb_listing <?php echo str_replace('tb_style_2', 'tb_style_1', $tbData->category_products_current['listing_classes']); ?> clearfix">
    <?php foreach ($seller['products'] as $product) { ?>
    <div class="tb_product tb_item <?php echo $product['tb_classes']; ?>">
      <a class="tb_thumb" href="<?php echo $product['href']; ?>">
        <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>"<?php if ($product['thumb_zoom']): ?> data-zoom-image="<?php echo $product['thumb_zoom']; ?>"<?php endif; ?> />
      </a>
      <div class="tb_item_info">
        <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
        <div class="tb_price_holder <?php echo $tbData->category_products_current['price_classes']; ?>">
          <?php if (!$product['special']): ?>
          <p class="tb_price"><?php echo $tbData->priceFormat($product['price']); ?></p>
          <?php else: ?>
          <p class="tb_price tb_promo_price">
            <span class="tb_old_price"><?php echo $tbData->priceFormat($product['price']); ?></span>
            <span class="tb_new_price"><?php echo $tbData->priceFormat($product['special']); ?></span>
          </p>
          <?php endif; ?>
        </div>
        <div class="tb_actions">
          <?php if ($product['show_cart'] && $product['quantity'] > 0): ?>
          <div class="tb_button_add_to_cart<?php echo $tbData->category_products_current['cart_button_position_classes']; ?>"<?php echo $tbData->category_products_current['cart_button_offset_attr']; ?>>
            <a class="<?php echo $tbData->category_products_current['cart_button_classes']; ?>" href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>');">
              <span data-tooltip="<?php echo $product['text_button_cart']; ?>"><?php echo $product['text_button_cart']; ?></span>
            </a>
          </div>
          <?php endif; ?>
          <?php if ($tbData->category_products_current['show_wishlist']): ?>
          <div class="tb_button_wishlist<?php echo $tbData->category_products_current['wishlist_button_position_classes']; ?>"<?php echo $tbData->category_products_current['wishlist_button_offset_attr']; ?>>
            <a class="<?php echo $tbData->category_products_current['wishlist_button_classes']; ?>" href="javascript:;" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
              <span data-tooltip="<?php echo $tbData->text_wishlist; ?>"><?php echo $tbData->text_wishlist; ?></span>
            </a>
          </div>
          <?php endif; ?>
          <?php if ($tbData->category_products_current['show_compare']): ?>
          <div class="tb_button_compare<?php echo $tbData->category_products_current['compare_button_position_classes']; ?>"<?php echo $tbData->category_products_current['compare_button_offset_attr']; ?>>
            <a class="<?php echo $tbData->category_products_current['compare_button_classes']; ?>" href="javascript:;" onclick="compare.add('<?php echo $product['product_id']; ?>');">
              <span data-tooltip="<?php echo $tbData->text_compare; ?>"><?php echo $tbData->text_compare; ?></span>
            </a>
          </div>
          <?php endif; ?>
        </div>
      </div>
    </div>
    <?php } ?>
  </div>
  <?php } ?>
  <!-- end products -->

</div>

<script class="noslot" type="text/javascript">
tbApp.onScriptLoaded(function() {

    <?php // RESPONSIVE ?>
    element_query('#{{widget_dom_id}} .tb_listing_options', [1000, 650, 350, 0]);

    <?php // ADJUST PRODUCT SIZE ?>
    adjustItemSize('#{{widget_dom_id}}', <?php echo $tbData->category_products_current['restrictions_json']; ?>)

});

<?php // ITEM BEAUTIFY ?>
tbApp.onWindowLoaded(function() {
    item_beautify('#{{widget_dom_id}}');
});
</script >
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>
