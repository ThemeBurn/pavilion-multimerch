<?php $tbData->echoHeader($header); ?>


<?php // Breadcrumbs -------------------------------------------------- ?>

<?php $tbData->slotStart('account/account.breadcrumbs'); ?>
<nav class="breadcrumbs">
  <ul class="clearfix">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php endforeach; ?>
  </ul>
</nav>
<?php $tbData->slotStop(); ?>

<?php // Page title --------------------------------------------------- ?>

<?php $tbData->slotStart('account/account.page_title'); ?>
<h1><?php echo $heading_title; ?></h1>
<?php $tbData->slotStop(); ?>

<?php // Page content ------------------------------------------------- ?>

<?php $tbData->slotStart('account/account.page_content'); ?>
<?php if ($success) { ?>
<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
<?php } ?>
<div class="tb_wrap">
  <div class="tb_col_1_3">
    <h2><?php echo $text_my_account; ?></h2>
    <ul class="tb_list_1">
      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
      <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
      <?php if ($tbData->common['wishlist_enabled']): ?>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <?php endif; ?>
    </ul>
  </div>
  <div class="tb_col_1_3">
    <h2><?php echo $text_my_orders; ?></h2>
    <ul class="tb_list_1">
      <?php if ($tbData->common['checkout_enabled']): ?>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
      <?php endif; ?>
      <?php if ($reward) { ?>
      <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
      <?php } ?>
      <?php if ($tbData->common['returns_enabled']): ?>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <?php endif; ?>
      <?php if ($tbData->common['checkout_enabled']): ?>
      <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
      <li><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
      <?php endif; ?> 
    </ul>
  </div>
  <div class="tb_col_1_3">
    <h2><?php echo $text_my_newsletter; ?></h2>
    <ul class="tb_list_1">
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div>
</div>
<?php $tbData->slotStop(); ?>


<?php $tbData->echoFooter($footer); ?>