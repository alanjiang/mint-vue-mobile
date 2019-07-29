<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="common.jsp"/>
<c:set var="weuser" value="${sessionScope.key_wechat_userinfo}"/> 
<c:set var="myorder" value="${sessionScope.key_my_order}"/>
<c:set var="shopinfo" value="${sessionScope.key_scan_shop}"/> 

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
   <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  
   <title>
     <c:if test="${not empty shopinfo}">
     ${shopinfo.shop_name}
     </c:if>
     <c:if test="${not empty weuser}">
       <c:if test="${not empty weuser.alipay}">
          <c:if test="${weuser.alipay eq 'DKDC'}">代客</c:if><c:if test="${weuser.alipay eq 'WXDC'}">支付宝</c:if>
       </c:if>
       <c:if test="${empty weuser.alipay}">
          <c:if test="${weuser.type eq 'DKDC'}">代客</c:if><c:if test="${weuser.type eq 'WXDC'}">微信</c:if>
       </c:if>
     </c:if>
     下单  
    </title>
 
  <link rel="stylesheet" href="${ctxPath}/css/mint-ui.css">
  <link rel="stylesheet" href="${ctxPath}/css/home.css">
  
</head>
<body>
  <div id="app">
   
  
  <mt-header title="汗牛点餐" style="background:#fff;color:#000;">
    <router-link to="/" slot="left">
    <c:if test="${not empty weuser}">
      <img src="${weuser.headimgurl}" width="30" height="30"/>
      </c:if>
      <c:if test="${empty weuser}">
                                     访客
      </c:if>
    </router-link>
    <mt-button icon="more" slot="right"></mt-button>
 </mt-header>
  
   <div style="padding:3px">
     <mt-cell title="本店WIFI名：wxdx_hotel，帐号：wxde_hotel,密码：8888666,欢迎使用!">
      
      <img slot="icon" src="../../images/broadcast.png">
</mt-cell>
   </div>
   
   <div class="swiper-container">
    <ul class="swiper-container-ul">
      <li class="swiper-container-ul-li actives">商品</li>
      <li class="swiper-container-ul-li">订单</li>
	    <li class="swiper-container-ul-li">商家介绍</li>
    </ul>
    <div class="swiper-wrapper">
      <div class="swiper-slide">
        <div class="content">
          <div class="left" id="left">
            <ul>
              <li v-for="item in sorts">{{item.name}}</li>
            </ul>
          </div>
          <div class="right" id="right">
            <ul>
              <li v-for="item in mers">
                <div class="class-title">{{item.sort}}</div>
                <div v-for="ite in item.list">
                  <div class="item">
                    <div class="item-left">
                        <div class="item-img"><img :src="ite.image" width=90 height=90></div>
                    </div>
                    <div class="item-right">
                      <div class="title">{{ite.name}}</div>
                      <div class="subtitle">¥<font color="red"><b>{{ite.price}}</b></font></div>
                      <div class="price"><mt-button type="primary" size="small">买买买</mt-button> </div>
                    </div>
					
                  </div>
                </div>
              </li>
			  
			  <!-- last element-->
			   <li>
			   
			   <div class="item-last">
			      
	
			   </div> 
			   
			   </li>
            </ul>
          </div>
        </div>
      </div>
      
      <div class="swiper-slide" style="display:none;">
      
	      <c:if test="${not empty myorder}">
	      
	       <mt-cell title="订单号:${myorder.orderForm.order_no}" >
	       
	        <span>总价:<font color="red">${myorder.totalPrice}</font></span>
	        <span> 
	        <c:if test="${myorder.orderForm.order_status eq 1}"> 待支付</c:if>
      			  <c:if test="${myorder.orderForm.order_status eq 2}">已支付</c:if>                      
      			 <c:if test="${myorder.orderForm.order_status eq 3}">交易关闭</c:if>
                         <c:if test="${myorder.orderForm.order_status eq 4}">代客点餐</c:if>
	        </span>
	       </mt-cell>
                
      		  
      		  
      		  <c:if test="${myorder.orderForm.order_status eq 1}">
      		     <a href="${ctxPath}/consumer/order_detail">
                   <button class="btn btn-lg btn-primary btn-block" type="button">去微信支付</button>
                </a>
                </c:if>
                <c:if test="${myorder.orderForm.order_status eq 2}">
                  <a href="${ctxPath}/consumer/order_detail"><button name="payBtn" class="btn btn-lg btn-primary btn-block" type="button">查看</button></a>
                </c:if>
      </c:if>	
	   <c:if test="${empty myorder}">
	       <p>
	       <mt-cell-swipe title="您当前无订单">
           </mt-cell-swipe>
        </p>
          <c:if test="${weuser.type eq 'DKDC'}">
             <p><a href="${ctxPath}/shop/${shop.id}/${tableNo}/1?flag=DKDC">
             <mt-button type="primary" size="large">去挑选</mt-button>
             </a></p>  
	          </c:if>
            <c:if test="${weuser.type ne 'DKDC'}">
             <p>
             <a href="${ctxPath}/shop/${shop.id}/${tableNo}/1">
             <mt-button type="primary" size="large">去挑选</mt-button>
             </a>
             </p>
           </c:if>
 
          </c:if>
             <br>
            <p> 
            
            <a href="${ctxPath}/consumer/order_history">
            <mt-button type="primary" size="large">历史订单</mt-button>
            
            </a> 
            </p>
                 
	      
      </div>
	  
	   <div class="swiper-slide" style="display:none;">
	   
	           <c:if test="${not empty shop}">
               <h4 class="text-center">${shop.shop_name}</h4>
               
               
               <p class="text-center"><img src="${s3BucketUrl}/hanniu/${shop.objectKey}" width="100" height="100"></p>
               
               <p>地址：${shop.shop_address}</p>
               
               <p>联系电话：<font color="red">${shop.shop_tel}</font></p>
               
               <p class="text-muted">${shop.shop_discription}</p>
               
               </c:if>
               
      </div>
    </div>
  </div>
    


   
    <!--  start of foot  -->
  
     <mt-tabbar v-model="selected" fixed>
      <mt-tab-item>
        
        
        <img slot="icon" src="../../images/home_active.png" style="cursor:pointer;" > 
            <a href="${ctxPath}/shop/getlist">主页 </a>
         </img>
        
       </mt-tab-item>
       
        <mt-tab-item>
         
          <img slot="icon" src="../../images/kefu.png" style="cursor:pointer;" > 
             <a href="#">客服</a>
         </img>
        
        </mt-tab-item>
        
         <mt-tab-item>
          
         <img slot="icon" src="../../images/cart.png" style="cursor:pointer;" > 
            	<a href="#">购物车</a>
         </img>
        
          </mt-tab-item>
          
           <mt-tab-item>
          
            <img slot="icon" src="../../images/me.png" style="cursor:pointer;" > 
            	<a href="#">我的</a>
            </img>
           
         
          </mt-tab-item>
    
    </mt-tabbar>
   <!--  end of foot  -->
  
  </div>
</body>
  <!-- import Vue before Mint UI -->
  <script src="${ctxPath}/js/vue.js"></script>
  <!-- import JavaScript -->
  <script src="${ctxPath}/js/mint-ui.js"></script>
  <script src="${ctxPath}/js/jquery.min.js"></script>
  <script src="${ctxPath}/js/json2.js"></script>
  <script>
    new Vue({
      el: '#app',
      data() {
    	
    	 return {
    		 selected: '主页', 
     		menus: [
     				{'name':'主页','image':'../../images/home_active.png','url':'/shop/getlist'},
     				{'name':'客服','image':'../../images/kefu.png','url':'/shop/kefu'},
     				{'name':'购物车','image':'../../images/cart.png','url':'/consumer/mycart'},
     				{'name':'我的','image':'../../images/me.png','url':'/consumer/order_detail'}
     				   
     			],
     			
     			//sorts:[{"name":"汤面类"},{"name":"炒面类"},{"name":"拌面类"},{"name":"凉菜类"},{"name":"河粉类"},{"name":"炒饭类"},{"name":"盖浇饭"},{"name":"小炒"},{"name":"汤类"},{"name":"其他"}],
     		    //mers: [{"sort":"汤面类","list":[{"id":"2392","title":"刀削面套餐","price":"30.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141021_29550cbf-1b82-42c5-8cc2-93b2e2841af2..jpg","unit":"份"},{"id":"2387","title":"烩面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104140002_3ba5b995-331a-487d-a81c-884cb7550233..jpg","unit":"份"},{"id":"2388","title":"烩饺","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104140152_49c3f939-fbc3-43e5-bb66-6740ad2f63cb..jpg","unit":"份"},{"id":"2369","title":"牛肉水饺","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104133951_b30e6ac9-d185-4317-8644-e4ba917d1450..jpg","unit":"份"},{"id":"2389","title":"牛肉泡馍","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104140329_fc9e7f25-e720-4117-bb36-3027316dbc4d..jpg","unit":"份"},{"id":"2391","title":"牛肉面套餐","price":"30.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104140632_42c2ff41-cb5c-4d39-a949-02769210dc03..jpg","unit":"份"},{"id":"2381","title":"番茄鸡蛋汤面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104135145_78b6fe5f-84ab-4d6d-8dc9-cc36c2b82de8..jpg","unit":"份"},{"id":"2385","title":"红烧刀削面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104135734_23a4a089-9264-4480-a2f6-1ec790756e1c..jpg","unit":"份"},{"id":"2386","title":"红烧牛肉面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104135851_5fc48d79-d6ad-4682-9d61-7426da364e60..jpg","unit":"份"},{"id":"2382","title":"羊肉拉面","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104135322_74292339-7c1f-4370-8c56-96a1ff11d023..jpg","unit":"份"},{"id":"2390","title":"羊肉泡馍","price":"17.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104140449_a482ae95-a1a7-4be4-88e8-a745038916fd..jpg","unit":"份"},{"id":"2383","title":"酸菜牛肉面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104135448_962ce1c5-c169-4144-9876-e599b13d2ddd..jpg","unit":"份"},{"id":"2384","title":"香辣牛肉面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104135607_181e1e8f-2066-49ec-a673-b5ccc9b328a1..jpg","unit":"份"}]},{"sort":"炒面类","list":[{"id":"2399","title":"丁丁拉面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141840_a53823e9-741e-4f95-b10f-29710c91d087..jpg","unit":"份"},{"id":"2397","title":"炒拉面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141601_ff9d2907-d573-4d6d-b913-211b6063c246..jpg","unit":"份"},{"id":"2400","title":"炒面片","price":"17.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141933_8d8bca43-f5c4-49a8-ad24-f3d59a412650..jpg","unit":"份"},{"id":"2398","title":"炮仗面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141735_56f84e1d-4044-4e82-86b2-5164e8d8334a..jpg","unit":"份"},{"id":"2395","title":"牛肉炒刀削面","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141403_ce44c032-786f-46cf-8c4f-8fad2eb41713..jpg","unit":"份"},{"id":"2393","title":"牛肉炒拉面","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141148_eaa85a20-bc94-4691-b145-9887baee4f14..jpg","unit":"份"},{"id":"2370","title":"番茄炒拉面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104131939_73e7223b-244d-4b1e-8123-6de39ae9bf1c..jpg","unit":"份"},{"id":"2396","title":"鸡蛋炒刀削面","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141504_1607bb53-9b3e-4c2b-b9bb-8ea330a40804..jpg","unit":"份"},{"id":"2394","title":"鸡蛋炒拉面","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104141251_b3cd74cc-b63a-4ddb-9940-d98b59dd6e8a..jpg","unit":"份"}]},{"sort":"拌面类","list":[{"id":"2408","title":"兰州干拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104143242_34632941-2561-4e23-9cf0-ad89fca0d74d..jpg","unit":"份"},{"id":"2414","title":"咖喱牛肉拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104150916_1118d680-2335-4f8c-9aca-87cf59ffa0a2..jpg","unit":"份"},{"id":"2421","title":"咖喱鸡块拌面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151755_d23678bc-d10e-448f-aefc-a9f888266ae0..jpg","unit":"份"},{"id":"2418","title":"土豆牛肉拌面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151402_04355c5f-2302-45d4-aa75-0a6271fbb822..jpg","unit":"份"},{"id":"2422","title":"孜然牛肉拌面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151901_07672045-58a1-46f9-aca8-4d9c1dbf859b..jpg","unit":"份"},{"id":"2424","title":"孜然羊肉拌面","price":"17.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152115_2a851423-f890-49e8-92e1-f4594e69c8e7..jpg","unit":"份"},{"id":"2423","title":"新疆拌面","price":"16.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152005_6c9e9856-10f1-4e58-aab7-143f1430e615..jpg","unit":"份"},{"id":"2412","title":"木耳牛肉拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104150705_395baabd-a33c-45ba-8584-d43a2177d9ec..jpg","unit":"份"},{"id":"2413","title":"洋葱炒肉拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104150809_43286356-e37d-488f-8eb7-302d35833a76..jpg","unit":"份"},{"id":"2416","title":"炸酱面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151139_814947a7-3eed-41e4-a3be-c378fd4edaad..jpg","unit":"份"},{"id":"2405","title":"牛肉凉面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104142759_e775697e-b74c-4769-bd42-493ad763e8cd..jpg","unit":"份"},{"id":"2401","title":"番茄鸡蛋拌面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104142232_29eb20d4-fdce-4557-811f-47d4c96723e7..jpg","unit":"份"},{"id":"2419","title":"红烧牛肉拌面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151523_8b160941-ce25-4107-9f0e-4b0e97d61e74..jpg","unit":"份"},{"id":"2415","title":"肉沫茄子拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151027_2e910cb7-3a74-4c0e-93ab-036cea6e7e83..jpg","unit":"份"},{"id":"2371","title":"葱油拌面","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104132527_02c951b7-26a1-4eb0-b241-3ce64a6028eb..jpg","unit":"份"},{"id":"2411","title":"葱爆牛肉拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104150546_48a0961c-940e-47ee-9975-2c8398a07758..jpg","unit":"份"},{"id":"2420","title":"蒜苔牛肉拌面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151642_91b3d15b-fe48-4cbc-9dc7-ec32f3ca3bdd..jpg","unit":"份"},{"id":"2409","title":"蘑菇炒肉拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104143354_d2d25dcf-84f1-41ca-a4f2-774c2038c721..jpg","unit":"份"},{"id":"2402","title":"酸辣白菜拌面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104142343_a14039d8-faea-4a4d-9d4f-8f24bbf34209..jpg","unit":"份"},{"id":"2403","title":"青椒土豆丝拌面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104142443_c7a144fd-cb6f-4f88-b972-280eedfa6a99..jpg","unit":"份"},{"id":"2410","title":"青椒牛肉拌面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104150435_22b776f1-aff3-471b-9cd4-02cb61034a6d..jpg","unit":"份"},{"id":"2404","title":"青椒鸡蛋拌面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104142700_d2d1b60c-4a93-4a15-8a79-dd274d6f1889..jpg","unit":"份"},{"id":"2417","title":"香辣鸡块拌面","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104151304_2882955f-abfe-4b53-9b09-3672123b00d0..jpg","unit":"份"},{"id":"2407","title":"鱼香牛肉凉面","price":"14.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104143120_da41f2fe-6cbb-4e05-886b-6efd0200afd8..jpg","unit":"份"},{"id":"2406","title":"鸡蛋凉面","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104142934_dd64f803-94b7-412c-abc6-dc74cbeb278d..jpg","unit":"份"}]},{"sort":"凉菜类","list":[{"id":"2428","title":"凉拌三丝","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152607_954cbc84-b917-4543-af27-96768e6adf94..jpg","unit":"份"},{"id":"2427","title":"凉拌土豆丝","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152631_f6c0cef7-2a91-414c-8558-1c02305662c6..jpg","unit":"份"},{"id":"2429","title":"凉拌木耳","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152729_ca1decdd-8345-41a9-bb3c-eee66fabc0f0..jpg","unit":"份"},{"id":"2426","title":"凉拌海带丝","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152403_8d9173de-aebd-4bbf-9197-0122d7eec565..jpg","unit":"份"},{"id":"2430","title":"凉拌牛肉","price":"40.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152815_10dbc352-0822-4927-866d-f143320b0cef..jpg","unit":"份"},{"id":"2372","title":"凉拌西红柿","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104132653_39e1b3ae-9be9-44e6-835a-071e554bb490..jpg","unit":"份"},{"id":"2425","title":"凉拌黄瓜","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152248_3a6d0fe8-1844-41b4-8350-8a648b7889f1..jpg","unit":"份"}]},{"sort":"河粉类","list":[{"id":"2436","title":"火腿鸡蛋炒河粉","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104153536_84bff85d-3498-4bef-a607-403fdec9b024..jpg","unit":"份"},{"id":"2433","title":"牛肉汤宽粉","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104153158_5b462696-e1f8-4c82-a04a-2c3c5056b4a0..jpg","unit":"份"},{"id":"2373","title":"牛肉汤河粉","price":"8.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104132911_396b166b-7a7e-4f5c-828d-06039e501eb9..jpg","unit":"份"},{"id":"2435","title":"牛肉炒河粉","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104153421_6cb83816-54c6-42de-926f-51379c88e5ef..jpg","unit":"份"},{"id":"2434","title":"鸡蛋汤宽粉","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104153311_abeab5c8-563c-4a55-9400-1b42927b2664..jpg","unit":"份"},{"id":"2431","title":"鸡蛋汤河粉","price":"8.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104152932_fa0a5f1d-c614-45de-8102-ad6dc80545b7..jpg","unit":"份"},{"id":"2432","title":"鸡蛋炒河粉","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104153036_0243daaa-9615-42e0-a54a-e717b4473b10..jpg","unit":"份"}]},{"sort":"炒饭类","list":[{"id":"2441","title":"兰州炒饭","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104154822_ccbd16f8-7725-4c5c-9ef2-c05d5b5d06be..jpg","unit":"份"},{"id":"2440","title":"咖喱炒饭","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104154730_5dfa243b-46f7-43db-8599-7ec39e837e77..jpg","unit":"份"},{"id":"2442","title":"扬州炒饭","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104154911_dde69e24-d73b-406f-ad3c-4245712834cd..jpg","unit":"份"},{"id":"2438","title":"牛肉炒饭","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104154503_2499a872-5be5-4fcb-b174-62b6ab787e8d..jpg","unit":"份"},{"id":"2374","title":"蛋炒饭","price":"8.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104133051_70e942a9-3a85-487a-bfe9-02a346ec59d1..jpeg","unit":"份"},{"id":"2439","title":"青椒牛肉炒饭","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104154605_00a94841-1591-443b-9d96-e0e385e28300..jpg","unit":"份"},{"id":"2437","title":"青椒鸡蛋炒饭","price":"9.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104153706_a4329069-0cd1-4020-8608-1675fafcf0d6..jpg","unit":"份"},{"id":"2375","title":"麻辣豆腐饭","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104133255_19682547-0fab-456b-9d95-a123d22449ba..jpg","unit":"份"}]},{"sort":"盖浇饭","list":[{"id":"2454","title":"咖喱牛肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160324_c74136f9-ff0f-459e-9c39-d393a26ac988..jpg","unit":"份"},{"id":"2461","title":"咖喱鸡块饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161017_fb5cebe1-9a02-4178-9417-e95001d2b32f..jpg","unit":"份"},{"id":"2458","title":"土豆牛肉饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160712_9ed25061-3b4a-49ba-908f-1d02c9a611a3..jpg","unit":"份"},{"id":"2446","title":"地三鲜饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155445_26b60d0e-a570-43c5-8b3b-d1f5aa00560a..jpg","unit":"份"},{"id":"2451","title":"孜然牛肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155957_a8deee50-671a-4b3f-8fcd-ad2e650c9704..jpg","unit":"份"},{"id":"2463","title":"孜然羊肉饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161222_51f20b83-cc53-4f33-9a30-8298048c6934..jpg","unit":"份"},{"id":"2460","title":"宫爆鸡丁饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160915_8be17c91-54cb-4f56-bd41-ba1f67e8590b..jpg","unit":"份"},{"id":"2456","title":"木耳炒肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160520_c76c4699-3e6f-4a60-9b82-bd6ae0bc506d..jpg","unit":"份"},{"id":"2448","title":"洋葱炒肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155646_f948fbfb-96e7-4668-ae94-0122f055bbbc..jpg","unit":"份"},{"id":"2445","title":"番茄鸡蛋饭","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155344_18fd5ac3-a876-4abe-b109-06227de10d83..jpg","unit":"份"},{"id":"2457","title":"红烧牛肉饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160615_ad31bc83-91ac-49bf-98a1-96c846e0ec0c..jpg","unit":"份"},{"id":"2459","title":"红烧鸡块饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160815_471d4330-552a-4309-a0a9-d5033e0c8d34..jpg","unit":"份"},{"id":"2452","title":"肉沫茄子饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160057_106e0d8d-15e6-4168-90dd-5a08a44bc933..jpg","unit":"份"},{"id":"2453","title":"葱爆牛肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160205_fd07fe5c-0f64-4af7-98b6-d688be5b3172..jpg","unit":"份"},{"id":"2462","title":"蒜苔炒肉饭","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161120_4e538ed4-dd64-40eb-8c29-e798def302c3..jpg","unit":"份"},{"id":"2455","title":"蘑菇炒肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104160419_5a13a8b1-b3aa-417d-b54c-6fe9a95a2b66..jpg","unit":"份"},{"id":"2443","title":"酸辣白菜饭","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155107_318276ee-18ce-4546-a0f9-309653d59cc8..jpg","unit":"份"},{"id":"2444","title":"青椒土豆丝饭","price":"12.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155225_ed236815-e701-4e70-b807-ed414599b07d..jpg","unit":"份"},{"id":"2447","title":"青椒牛肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155544_dedde50a-e197-484b-bc3c-aa7a00417d05..jpg","unit":"份"},{"id":"2450","title":"鱼香牛肉饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155852_2ae4e3bc-0fd9-47df-b646-eb393214e2ee..jpg","unit":"份"},{"id":"2449","title":"鱼香茄子饭","price":"13.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104155747_df1c320b-73ba-4752-98a1-3a7383bca887..jpg","unit":"份"}]},{"sort":"小炒","list":[{"id":"2480","title":"兰州炒肉片","price":"45.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162955_40aaf2ba-69de-45e6-9fc8-1e6fd09130a3..jpg","unit":"份"},{"id":"2477","title":"土豆烧牛肉","price":"45.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162620_8440464a-f329-48f0-af2f-77b58be0e6ef..jpg","unit":"份"},{"id":"2481","title":"孜然羊肉","price":"50.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163104_344b1eaa-0ede-49dc-ae9d-c8573a9c7c24..jpg","unit":"份"},{"id":"2465","title":"家常土豆丝","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161439_04e7f209-98cd-4346-a063-752aeafd062f..jpg","unit":"份"},{"id":"2483","title":"新疆大盘鸡","price":"50.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163318_3c35dc75-2b99-4de4-aa70-3d26a8a4fab9..jpg","unit":"斤"},{"id":"2472","title":"木耳炒肉","price":"30.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162126_a23019ce-bc74-4956-9178-880bf779b5e9..jpg","unit":"份"},{"id":"2376","title":"清炒上海青","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104133424_0ab3108f-4e1a-4a99-b2af-669ee332511b..jpg","unit":"份"},{"id":"2482","title":"牙签羊肉","price":"50.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163203_d76d2204-b9b4-412d-b048-7a376b3e1c62..jpg","unit":"份"},{"id":"2466","title":"番茄炒蛋","price":"17.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161531_fe90fefa-8845-4b0d-a8af-13dbc203899e..jpg","unit":"份"},{"id":"2479","title":"红烧牛肉","price":"45.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162810_6b9894bf-f4dc-48b3-bbe0-8d3ecf6454f9..jpg","unit":"份"},{"id":"2476","title":"红烧鸡块","price":"40.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162524_9833f45e-48fb-4547-b27b-979ae1e370dd..jpg","unit":"份"},{"id":"2474","title":"营爆鸡丁","price":"35.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162328_1c6020f4-93d4-4a91-b491-a2a42037a6c6..jpg","unit":"份"},{"id":"2475","title":"葱爆牛肉","price":"40.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162419_9a319040-ab3e-442c-ae79-36859ed57f3c..jpg","unit":"份"},{"id":"2478","title":"葱爆羊肉","price":"45.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162719_a824e222-7458-4cae-a3e1-7252dd74aec9..jpg","unit":"份"},{"id":"2473","title":"蒜苔炒肉","price":"35.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162227_851045d8-e8ca-4759-a3a8-8b0d5773164c..jpg","unit":"份"},{"id":"2470","title":"蘑菇炒肉","price":"28.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161926_d3030eed-cbcc-4ba1-886c-f8f6582fe710..jpg","unit":"份"},{"id":"2468","title":"虎皮青椒","price":"20.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161731_75c69f48-1b35-4a19-b077-690ece3cd943..jpg","unit":"份"},{"id":"2464","title":"酸辣白菜","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161350_561d144c-6920-4383-bf14-2dee234643d2..jpg","unit":"份"},{"id":"2469","title":"青椒炒肉","price":"25.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161824_0f28264a-c7ea-4ea8-bacb-f00568f2c868..jpg","unit":"份"},{"id":"2467","title":"青椒炒蛋","price":"17.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104161624_143b3291-a5d1-419f-bcf9-d61731632ae6..jpg","unit":"份"},{"id":"2485","title":"青菜豆腐汤","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163537_30837aa9-2c2a-4887-888f-ddc5b75bd1c8..jpg","unit":"份"},{"id":"2471","title":"香烤土豆片","price":"28.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104162031_cb9b263c-36c1-4831-85e5-3e85b78b4d46..jpg","unit":"份"}]},{"sort":"汤类","list":[{"id":"2486","title":"牛肉汤","price":"15.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163632_881688e6-dcb1-4151-9806-5ab11e3ff27c..jpg","unit":"份"},{"id":"2377","title":"番茄鸡蛋汤","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104133600_8f6bd3b1-1708-42b8-a3a9-fda10c9a3c2a..jpg","unit":"份"},{"id":"2484","title":"紫菜鸡蛋汤","price":"10.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163447_f3ed1ddf-b31a-496d-b7f3-a776ac45a55d..jpg","unit":"份"},{"id":"2487","title":"羊肉汤","price":"25.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163731_6b2e0505-591d-488a-a2a8-ffa938fa6598..jpg","unit":"份"},{"id":"2367","title":"鸡蛋刀削面","price":"9.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104132250_72d11bca-4503-4754-9f09-40ea88591d50..jpg","unit":"份"}]},{"sort":"其他","list":[{"id":"2378","title":"白米饭","price":"2.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104133721_c5e45f9a-ae7f-4b56-be91-b5cc6c762844..jpg","unit":"份"},{"id":"2488","title":"荷包蛋","price":"2.00","count":"0","img":"https://s3.cn-northwest-1.amazonaws.com.cn/hanniu/merchandise/thumb-73_20181104163831_ecd0265c-5494-48a5-80fa-729d0be515d1..jpg","unit":"个"}]}]
                sorts:[],
                mers:[]
    	 }
    	  
      },
      methods: {
    	  
    	resetCanvas: function() {
    		
    		$('.content').css('height',$('.right').height());
    	    $('.left ul li').eq(0).addClass('active');
    	    $(window).scroll(function(){
    	      if($(window).scrollTop() >= 150){
    		   
    	        $('.swiper-container-ul').css('position','fixed');
    	        $('.left').css('position','fixed');
    	        $('.right').css('margin-left',$('.left').width());
    	      }else {
    		  
    	        $('.swiper-container-ul').css('position','');
    	        $('.left').css('position','');
    	        $('.right').css('margin-left','');
    	      };
    	      
    	      $('.right ul li').each(function(){
    	        var target = parseInt($(this).offset().top-$(window).scrollTop()-150);
    	        var i = $(this).index();
    	        if (target<=0) {
    	          $('.left ul li').removeClass('active');
    	          $('.left ul li').eq(i).addClass('active');
    	        }
    	      });
    	    });
    	    $('.left ul li').click(function(){
    	      var i = $(this).index('.left ul li');
    	      $('body, html').animate({scrollTop:$('.right ul li').eq(i).offset().top-40},500);
    	    });
    		
    		//guide bar 
    	    $('.swiper-container-ul-li').click(function(){
    	      var index = $(this).index();
    	      if(index == 0){
    	        $('.swiper-slide').eq(0).show();
    	        $('.swiper-container-ul-li').eq(0).addClass('actives');
    	        $('.swiper-slide').eq(1).hide();
    	        $('.swiper-container-ul-li').eq(1).removeClass('actives');
    			  $('.swiper-slide').eq(2).hide();
    	        $('.swiper-container-ul-li').eq(2).removeClass('actives');
    	      }else if(index==1) {
    	        $('.swiper-slide').eq(0).hide();
    	        $('.swiper-container-ul-li').eq(0).removeClass('actives');
    			$('.swiper-slide').eq(2).hide();
    	        $('.swiper-container-ul-li').eq(2).removeClass('actives');
    	        $('.swiper-slide').eq(1).show();
    	        $('.swiper-container-ul-li').eq(1).addClass('actives');
    	      }
    		  else{
    		  
    		    $('.swiper-slide').eq(0).hide();
    	        $('.swiper-container-ul-li').eq(0).removeClass('actives');
    			$('.swiper-slide').eq(1).hide();
    	        $('.swiper-container-ul-li').eq(1).removeClass('actives');
    	        $('.swiper-slide').eq(2).show();
    	        $('.swiper-container-ul-li').eq(2).addClass('actives');
    		  }
    	    });
    	} , 
        handleClick: function() {
          this.$toast('Hello world!')
        },
        
        fetchProductList: function() {
        	var ctxPath='${ctxPath}';
            var __this=this;
           
            $.ajax({
             type:"POST",
             contentType: "application/json; charset=utf-8",
             url:ctxPath+"/shop/getproducts", 
             data:"{\"java\":\"OK\"}",
             datatype: "json",
             success: function (message) 
  		     {
  			   var resMsg=message.resMsg;
  			   var resCode=message.resCode;
  			   if(message.mers){
                 __this.mers=message.mers;
                 message.mers.forEach(t=>{
                	 __this.sorts.push({"name":t.sort});
                 });
                 __this.$nextTick(() => {
                	 __this.resetCanvas();
                	 
                   }); 
                 
  			   }
          
              },
              
              error: function (jqXHR, textStatus, errorThrown) 
  		      {
                 
  			     alert("Error"); 
              }
                
           });
       },
        
        switchIcon (src) 
        {
    	     
                 this.menus.forEach(function(item){
            	 var len =item['image'].indexOf('_active.png');
                 if(len > 0)
                 {
                    var preffix=item['image'].substring(0, len);
                    item['image']=preffix+'.png';
                 }
                 
            	 if(item['image'] == src){
            		 
            		 window.location=ctxPath+item['url'];
            	 }
            	 
             });
            	 
             
             
             
        }
      },
      
      created () {
      	
     	 
     	 
     	//this.fetchProductList();
     },
     
     mounted () {
    	 this.fetchProductList();
    	 
     }
      
    });
  </script>
  
</html>