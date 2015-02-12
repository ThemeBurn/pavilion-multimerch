<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('seller/catalog-seller/products.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('seller/catalog-seller/products.page_title'); ?>
<h1 ><?php echo $ms_catalog_seller_products; ?></h1 >
<?php $tbData->slotStop(); ?>

<?php // Product listing ---------------------------------------------- ?>

<?php TB_StaticThemeManager::get()->getThemeExtension()->getPlugin('product')->filterOcModuleProducts(new sfEvent($this, 'dummy'), array('products' => &$seller['products'])); ?>
<?php $tbData->slotStartSystem('seller/catalog-seller/products.page_content'); ?>
<?php if ($seller['products']) { ?>
<nav class="tb_listing_options tb_style_<?php echo $tbData->category_products_current['products_style']; ?><?php if ($tbData->category_products_current['products_style'] == 1) echo ' tb_bg_str_1'; ?> tb_row tb_row_full tb_gut_0">
  <div class="tb_wrap">
    <div class="tb_col_1_2">
      <div class="tb_view_mode tb_nav">
        <ul>
          <li class="tb_button_grid">
            <a class="tb_icon_16 <?php if ($tbData->product_listing_type == 'grid'): ?>tb_main_color<?php endif; ?>" href="javascript:;"><?php echo $button_grid; ?></a>
          </li>
          <li class="tb_button_list">
            <a class="tb_icon_16 <?php if ($tbData->product_listing_type == 'list'): ?>tb_main_color<?php endif; ?>" href="javascript:;"><?php echo $button_list; ?></a>
          </li>
        </ul>
      </div>
      <?php if ($tbData->common['compare_enabled']): ?>
      <a class="tb_compare_total tb_border_str_1" href="<?php echo $compare; ?>"><?php echo $text_compare; ?></a>
      <?php endif; ?>
    </div>
    <div class="tb_col_1_2">
      <div class="tb_listing_limit">
        <label><?php echo $text_limit; ?></label>
        <select onchange="location = this.value;">
          <?php foreach ($limits as $limits) { ?>
          <?php if ($limits['value'] == $limit) { ?>
          <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
      </div>
      <div class="tb_listing_sort">
        <label><?php echo $text_sort; ?></label>
        <select onchange="location = this.value;">
          <?php foreach ($sorts as $sorts) { ?>
          <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
          <?php } ?>
          <?php } ?>
        </select>
      </div>
    </div>
  </div>
</nav>

<div class="tb_products tb_listing <?php echo $tbData->category_products_current['listing_classes']; ?> clearfix">
  <?php foreach ($seller['products'] as $product): ?>
  <div class="tb_product tb_item <?php echo $product['tb_classes']; ?>">
    <?php if ($product['thumb'] && $tbData->category_products_current['show_thumb']): ?>
    <a class="tb_thumb<?php if ($product['thumb_zoom']): ?> tb_zoom<?php endif; ?>" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>"<?php if ($product['thumb_zoom']): ?> data-zoom-image="<?php echo $product['thumb_zoom']; ?>"<?php endif; ?> />
    </a>
    <?php if ($product['thumb_hover']): ?>
    <a class="tb_thumb tb_thumb_hover" href="<?php echo $product['href']; ?>">
      <img src="<?php echo $product['thumb_hover']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
    </a>
    <?php endif; ?>
    <?php endif; ?>
    <div class="tb_item_info">
      <?php if ($tbData->category_products_current['show_title']): ?>
      <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
      <?php endif; ?>
      <?php if ($tbData->category_products_current['show_price'] && $product['price']): ?>
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
      <?php endif; ?>
      <?php if ($tbData->category_products_current['show_desc'] && $product['description']): ?>
      <p class="tb_description"><?php echo $product['description']; ?></p>
      <?php endif; ?>
      <?php if ($tbData->category_products_current['show_rating'] && $product['rating']): ?>
      <div class="tb_rating_holder">
        <p class="tb_rating tb_rating_5" title="<?php echo $product['rating']; ?>/5">
          <span class="tb_base"></span>
          <span class="tb_percent" style="width: <?php echo $product['rating'] * 2 ; ?>0%;"></span>
        </p>
        <span class="tb_average"><?php echo $product['rating']; ?>/5</span>
      </div>
      <?php endif; ?>
      <?php if ($product['show_cart'] && $product['quantity'] < 1 && !$tbData['config']->get('config_stock_checkout')): ?>
      <p class="tb_label_stock_status"><?php echo $product['stock_status']; ?></p>
      <?php endif; ?>
      <?php if ($product['show_cart'] || $tbData->category_products_current['show_wishlist'] || $tbData->category_products_current['show_compare']): ?>
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
      <?php endif; ?>
    </div>
    <?php if ($tbData->category_products_current['show_label_sale'] && $product['special']): ?>
    <span class="tb_label_special"><span><?php echo $product['savings_num']; ?><span>%</span></span><small>off</small></span>
    <?php endif; ?>
    <?php if ($tbData->category_products_current['show_label_new'] && $product['is_new']): ?>
    <span class="tb_label_new"><?php echo $tbData->text_label_new; ?></span>
    <?php endif; ?>
  </div>
  <?php endforeach; ?>
</div>

<div class="pagination tb_border_str_2">
  <?php echo str_replace('pagination', 'links', $pagination); ?>
  <div class="results"><?php echo $results; ?></div>
</div>

<?php } else { ?>

<p class="tb_empty"><?php echo $text_empty; ?></p>

<?php } ?>

<script class="noslot" type="text/javascript">
tbApp.onScriptLoaded(function() {

    $('#{{widget_dom_id}} .tb_view_mode li').bind("click", function() {
      if ($(this).find("a").is(".tb_main_color")) {
        return false;
      }
      $.cookie('listingType', $(this).is(".tb_button_grid") ? 'grid' : 'list', { path: '/' });
      location.reload();
    });

    <?php // RESPONSIVE ?>
    element_query('#{{widget_dom_id}} .tb_listing_options', [1000, 650, 350, 0]);

    <?php if (!$tbData->is_touch): ?>

    <?php // THUMB HOVER ?>
    <?php if ($tbData->category_products_current['thumbs_hover_action'] != 'none'): ?>
    thumb_hover('#{{widget_dom_id}}', '<?php echo $tbData->category_products_current['thumbs_hover_action']; ?>')
    <?php endif; ?>

    <?php // THUMB ZOOM ?>
    <?php if ($tbData->category_products_current['thumbs_hover_action'] == 'zoom'): ?>
    $('#{{widget_dom_id}}').find('.tb_zoom > img').elevateZoom({
      zoomType:           'inner',
      zoomWindowFadeIn:   300,
      zoomWindowFadeOut:  300,
      cursor:             'crosshair'
    });
    <?php endif; ?>

    <?php // PRODUCT HOVER ?>
    <?php if ($tbData->category_products_current['elements_hover_action'] != 'none'): ?>
    item_hover('#{{widget_dom_id}}', '<?php echo $tbData->category_products_current['active_elements']; ?>', '<?php echo $tbData->category_products_current['hover_elements']; ?>', '<?php echo $tbData->category_products_current['elements_hover_action']; ?>');
    <?php endif; ?>

    <?php endif; ?>

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