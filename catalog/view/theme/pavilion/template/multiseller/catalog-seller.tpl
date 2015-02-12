<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('seller/catalog-seller.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('seller/catalog-seller.page_title'); ?>
<h1 ><?php echo $ms_catalog_sellers_heading; ?></h1 >
<?php $tbData->slotStop(); ?>

<?php // Product listing ---------------------------------------------- ?>

<?php TB_StaticThemeManager::get()->getThemeExtension()->getPlugin('product')->filterOcModuleProducts(new sfEvent($this, 'dummy'), array('products' => &$sellers)); ?>
<?php $tbData->slotStartSystem('seller/catalog-seller.page_content'); ?>
<?php if (isset($sellers) && $sellers) { ?>
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
    </div>
    <div class="tb_col_1_2">
      <div class="tb_listing_limit">
        <label><?php echo $text_limit; ?></label>
        <select id="input-limit" class="form-control" onchange="location = this.value;">
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
        <select id="input-sort" class="form-control" onchange="location = this.value;">
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
  <?php foreach ($sellers as $seller) { ?>
  <div class="ms-sellerprofile tb_item <?php echo $seller['tb_classes']; ?>">
    <a class="tb_thumb" href="<?php echo $seller['href']; ?>">
      <img src="<?php echo $seller['thumb']; ?>" title="<?php echo $seller['nickname']; ?>" alt="<?php echo $seller['nickname']; ?>"<?php if ($seller['thumb_zoom']): ?> data-zoom-image="<?php echo $seller['thumb_zoom']; ?>"<?php endif; ?> />
    </a>
    <div class="tb_item_info">
      <h3><a href="<?php echo $seller['href']; ?>"><?php echo $seller['nickname']; ?></a></h3>
      <?php if ($seller['country']) { ?>
      <p class="country">
        <img class="country-flag" src="<?php echo $seller['country_flag']; ?>" alt="<?php echo $seller['country']; ?>" title="<?php echo $seller['country']; ?>" />
        <span class="country-name"><?php echo $seller['country']; ?></span>
      </p>
      <?php } ?>
      <dl>
        <?php if ($seller['company']) { ?>
        <dt class="compaty"><?php echo $ms_catalog_sellers_company; ?></dt>
        <dd><?php echo $seller['company']; ?></dd>
        <?php } ?>
        <?php if ($seller['website']) { ?>
        <dt class="website"><?php echo $ms_catalog_sellers_website; ?></dt>
        <dd><?php echo $seller['website']; ?></dd>
        <?php } ?>
        <dt class="totalsales"><?php echo $ms_catalog_sellers_totalsales; ?></dt>
        <dd><?php echo $seller['total_sales']; ?></dd>
        <dt class="totalproducts"><?php echo $ms_catalog_sellers_totalproducts; ?></dt>
        <dd><?php echo $seller['total_products']; ?></dd>
      </dl>
      <p class="tb_description"><?php echo $seller['description']; ?></p>
    </div>
  </div>
  <?php } ?>
</div>

<div class="pagination tb_border_str_2">
  <?php echo str_replace('pagination', 'links', $pagination); ?>
  <div class="results"><?php echo $results; ?></div>
</div>

<?php } else { ?>

<p class="tb_empty"><?php echo $ms_catalog_sellers_empty; ?></p>

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