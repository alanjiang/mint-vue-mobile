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
    <link rel="stylesheet" type="text/css" href="${ctxPath}/css/Vue.css">
	
	 <link rel="stylesheet" type="text/css" href="${ctxPath}/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/css/cart.css">
	<link rel="stylesheet" type="text/css" href="${ctxPath}/css/mer_detail.css">
	<!--  jquery.toast  -->
	<link rel="stylesheet" type="text/css" href="${ctxPath}/css/jquery.toast.min.css">
	
	 <style>
    main_nav_bottom{ 
    padding:10px 5px;
    position:fixed;
    bottom: 0;
    width: 100%;
    height: 40px;
    background-color: #343a40 !important;
   }
  </style>
  
   
  

  <head>
<body>

 <div id="app">
   <!-- header start -->
  <nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#"> 
      <span>
      <img src="${ctxPath}/images/logo.gif"/>
      <strong>点了么</strong>&nbsp;hi,
      <c:if test="${not empty weuser}">
      <img src="${weuser.headimgurl}" width="30" height="30"/>
      </c:if>
      <c:if test="${empty weuser}">
                                     访客
      </c:if>
      <span>                              
        </a>
    </div>
    <div id="navbar" class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">主页</a></li>
        <li><a href="#about">购物车</a></li>
        <li><a href="#contact">订单</a></li>
       
      </ul>
      <ul class="nav navbar-nav navbar-right">
       
      <c:if test="${not empty shopinfo}">
      <p style="padding:5px;" class="text-white">${shopinfo.shop_name}</p>
         <c:if test="${not empty shopinfo.shop_name}">
            <c:if test="${not empty shopinfo.tableNo}">
                <p style="padding:5px;" class="text-muted">桌位号：${shopinfo.tableNo}</p>      
            </c:if>
         </c:if>  
         <c:if test="${not empty shopinfo.shop_address}">
             <p  style="padding:5px;" class="text-muted">${shopinfo.shop_address}</p>      
         </c:if> 
         <c:if test="${not empty shopinfo.shop_tel}">
            <p  style="padding:5px;" class="text-muted">${shopinfo.shop_tel}</p>      
         </c:if> 
          
      </c:if>
         
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</nav>
  
  <!-- header end -->

  
  
  <div class="swiper-container" style="margin-top:50px;">
    <ul class="swiper-container-ul">
      <li class="swiper-container-ul-li actives">商品</li>
      <li class="swiper-container-ul-li">订单</li>
	    <li class="swiper-container-ul-li">商家介绍</li>
    </ul>
    
    
      <div class="swiper-wrapper">
      <div class="swiper-slide">
        <div class="content">
          <div  class="left" id="left">
            <ul>
              <li v-for="item in sorts">{{item.name}}</li>
            </ul>
          </div>
          <div  class="right" id="right">
            <ul>
              <li v-for="item in mers">
                <div class="class-title">{{item.sort}}</div>
                <div v-for="ite in item.list">
                  <div class="item">
                    <div class="item-left">
                        <div class="item-img"><img :src="ite.image" width=90 height=90 @click="showDetail(ite.id)"></div>
                    </div>
                    <div class="item-right">
                      <div class="title">{{ite.name}}</div>
                      <div class="subtitle">¥<font color="red"><b>{{ite.price}}</b></font></div>
                      <div class="price"><button type="button" class="btn btn-warning" @click="showDetail(ite.id)">我要点</button></div>
                    </div>
					
                  </div>
                </div>
              </li>
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
                <table class="table">
      		     <thead><tr><th>订单号</th><th>总价</th><th>状态</th></tr></thead>
      			 <tbody>
      			  <tr>
      			  <td>${myorder.orderForm.order_no}</td>
      			  <td><font color="red">${myorder.totalPrice}</font></td>
      			  <td> 
      			  <c:if test="${myorder.orderForm.order_status eq 1}"> 待支付</c:if>
      			  <c:if test="${myorder.orderForm.order_status eq 2}">已支付</c:if>                      
      			 <c:if test="${myorder.orderForm.order_status eq 3}">交易关闭</c:if>
                         <c:if test="${myorder.orderForm.order_status eq 4}">代客点餐</c:if>
      			  </td>
      			  </tr>
      			 </tbody>
      		  </table>
      		  
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
	       <p class="alert alert-warning">您当前无订单</p>

          <c:if test="${weuser.type eq 'DKDC'}">
             <p><a href="${ctxPath}/shop/${shop.id}/${tableNo}/1?flag=DKDC"><button type="button" class="btn btn-lg btn-primary btn-block">去挑选</button></a></p>  
	  </c:if>
            <c:if test="${weuser.type ne 'DKDC'}">
             <p><a href="${ctxPath}/shop/${shop.id}/${tableNo}/1"><button type="button" class="btn btn-lg btn-primary btn-block">去挑选</button></a></p>
           </c:if>
 
          </c:if>
             <br>
            <p> <a href="${ctxPath}/consumer/order_history"><button type="button" class="btn btn-lg btn-primary btn-block">历史订单 </button></a> </p>
                 
	  
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
  
  
    
  <!-- foot menu sart -->
  
       <div class="main_nav_bottom">
         <nav class="navbar navbar-default navbar-fixed-bottom">
         <div class="container" align="center">

         <style>
           .nav-tabs{text-align: center;height: 40px;line-height: 40px;}
           
           .badge-light{
           color:#fff;background-color:red;
       }

       </style>


       <ul class="nav nav-tabs nav-tabs-justified">

           <div class="row" align="center">
           
             <div class="col-md-3 col-sm-3 col-xs-3" align="center">
             
              <c:if test="${not empty shopinfo}">
               <li>
               <c:if test="${not empty weuser}">
               <c:if test="${weuser.type eq 'DKDC'}">
                 <a href="${ctxPath}/shop/${shopinfo.id}/${shopinfo.tableNo}/1?flag=DKDC">
                </c:if>
                 <c:if test="${weuser.type ne 'DKDC'}">
                 <a href="${ctxPath}/shop/${shopinfo.id}/${shopinfo.tableNo}/1">
                </c:if>
               </c:if>
                <img src="${ctxPath}/images/home_active.png" width="35" height="35">
               </a>
              
               </li>
               </c:if>
               </div>
               
               <div class="col-md-3 col-sm-3 col-xs-3" align="center">
               
               <li>
               <a href="${ctxPath}/consumer/mycart">
               <img src="${ctxPath}/images/cart.png" width="35" height="35">
               <c:if test="${not empty sessionScope.key_my_cart}">
                  <c:if test="${not empty sessionScope.key_my_cart.merItems}">
                      <c:if test="${fn:length(sessionScope.key_my_cart.merItems) gt 0}">
                        <span class="badge badge-light" id="cartDiv">  ${fn:length(sessionScope.key_my_cart.merItems)} </span>
                      </c:if>
                  </c:if>
               </c:if> 
               
               <c:if test="${empty sessionScope.key_my_cart}">
                   <span class="badge badge-light" id="cartDiv"></span>
               </c:if>
               </a> 
              
               </li>
               
               </div>
               
                <div class="col-md-3 col-sm-3 col-xs-3" align="center">
                  <a href="#" @click="kefuWin">
                    <img src="${ctxPath}/images/kefu.png" width="35" height="35">
                  </a>
                 
                </div>
               
               <div class="col-md-3 col-sm-3 col-xs-3" align="center">
               
               <li>
               <a href="${ctxPath}/consumer/order_detail">
               <img src="${ctxPath}/images/me.png" width="35" height="35">
               
               <c:if test="${not empty sessionScope.key_my_order}">
                 <c:if test="${not empty sessionScope.key_my_order.merItems}">
                   <c:if test="${fn:length(sessionScope.key_my_order.merItems) gt 0}">
                     <span class="badge badge-light" id="orderDiv">${fn:length(sessionScope.key_my_order.merItems)}</span>
                   </c:if>
                 </c:if> 
               </c:if>
               <c:if test="${empty sessionScope.key_my_order}">
                 <span class="badge badge-light" id="orderDiv"></span>
               </c:if>
               </a>
              
               </li>
               </div>
               
               </div>
               </ul>
               </div>
               </nav>
               </div>

         
        <!-- foot menu end -->
        
        
        <!--  Dialog start -->
        
  
 <div class="modal fade"  id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
 <div class="modal-dialog" role="document">  
     <div class="modal-content">  
         <div class="modal-header">  
             <button type="button" class="close" data-dismiss="modal" aria-label="Close">  
                 <span aria-hidden="true">×</span>  
             </button>  
             <h4 class="modal-title" id="myModalLabel">提示</h4>  
         </div>  
         <div class="modal-body" style="color:#000000">  
         
           <!--  商品主信息开始 -->
            <div class="row">
             <div class="col-xs-5" > 
                <img  :src="mer_img" width="120" height="120"> 
             </div>
             
             
             <div class="col-xs-5"> 
             
                
                   <p> {{ mer_name }}  </p>
                   
                   <p style="size:16px;color:red;" v-if="price_span == null">¥{{price}}</p>
                   <p style="size:16px;color:red;" v-else>¥{{price_span}}</p>
                   <p v-show="remain !=null">库存：{{remain}}</p>
                  
                
             </div> 
             
             
             <br>
             
            </div>  <!--  end of row  -->
            
             <!-- 商品主信息结束 -->
             
             
            <!--  商品规格开始 -->
            <div class="row">
            
            
               
            <div v-for="(attr,index1) in mer_attrs">
  
             <p class="title">{{attr.attr_key}}</p>
       
             <ul class="guige">
               <li v-for="(item,index) in attr.attr_values" class="label" 
            :class="{label_active: index1 == 0 ? selected1 == index : selected2 == index}"  @click="index1 == 0 ? chooseItem1(attr,index,item.attr_id):chooseItem2(attr,index,item.attr_id)" >
             {{ item.attr_value }}  
              </li> 
            </ul>
            <div class="clear"></div>
      
             </div>
            
            
             
           </div> <!--  end of row  -->
          
 
        <div class="row">
        
          
           <div class="col-xs-5"> 
             数量
                    <span class="cart-control-minus" @click="subNum()">-</span>
                    <font color="red">{{count}}</font>
                    <span class="cart-control-add" @click="addNum()">+</span>
          </div>
          <div class="col-xs-7">单价: <font color="red">¥{{price}}</font>  &nbsp;</div>
        
      </div> <!--  end of row  -->
      <div class="row">
      
      <div class="col-xs-5"> </div> <div class="col-xs-7" >    总价:<font color="red" size="18px">¥{{total_price  }}</font> </div>
        
      
      </div>
      
       <!--  商品规格结束 -->      
         
         

         </div>           
         
         <div class="modal-footer">  
            <button type="button"  @click="hideModal" class="btn btn-default" data-dismiss="modal">不买了</button> 
             <button type="button" @click="addToCart" class="btn btn-warning">加入购物篮</button>  
         </div>  
     </div>  
 </div>  
</div>  




        
        <!--  Dialog end -->
  
 

</div> <!--  end of vue div id="app" -->
   
  <script src="${ctxPath}/js/jquery.min.js"></script>
  <script src="${ctxPath}/js/vue.min.js"></script>
  <script src="${ctxPath}/js/bootstrap.min.js"></script>
  <script src="${ctxPath}/js/json2.js"></script>
<!--  vue scrip start -->
   <script src="${ctxPath}/js/jquery.toast.min.js"></script>
    <script src="${ctxPath}/js/jquery.endless-scroll.js"></script>
   
   
<script>
    new Vue({
      el: '#app',
      data() {
    	
    
    	 return {
    		  
    		    ctxPath:'${ctxPath}',
    		    xmlHttp:null,
     			sorts:[],
     			//商品列表
                mers:[],
                mer_name:'',
                mer_price:null,
                mer_img:null,
                mer_attrs:null,
                //挑选商品的对象
                product:null,
                attrs:[],
                selected1:-1,
                selected2:-1,
                attr_id1:null,
                attr_id2:null,
                //label值
                attr_key1:null,
                attr_value1:null,
                attr_key2:null,
                attr_value2:null,
                label:null,
                count:1,
                price:0,
                total_price:0,
                remain:null,
                product:null,
                symbol:'',
                price_span:null
    	 }
    	  
      },
      methods: {
    	  
    	  leftScroll:function(){
    		  $('#left').endlessScroll({
    		        pagesToKeep: 10,
    		        fireOnce: false
    		       
    		        
    		        
    		      });
    		  $('#right').endlessScroll({
    		        pagesToKeep: 10,
    		        fireOnce: false
    		       
    		        
    		        
    		      });
    	  },
    	  kefuWin: function(){
    		  this.showMsg("功能正在建设中，请稍等...");
    	  },
    	//农斋myDialog.vue复用开始
    	  getTotalPrice:function(){
    	        
              return  this.count*this.price;
           },
           addNum:function(){
           
              if(!this.judgeAttrComplete()){
               return false;
              }
              if(this.remain !=null ){
                 if(this.count >= this.remain){
                    this.count==this.remain;
                 }
              }
              this.count++;
              this.total_price=this.price*this.count.toFixed(2);
              
           },
           subNum:function(){
             
             if(this.count==1){
               return false;
             }
             if(!this.judgeAttrComplete()){
               return false;
             }
             this.count--;
             this.total_price=this.price*this.count.toFixed(2);
           },
           
           
           
           judgeAttrComplete:function(){
                if(this.product.attrs.length == 2 ){
                  if(this.attr_id1 ==null  || this.attr_id2 == null){
                	  
                	  this.showMsg('规格没有全面选择');
                	  
                	 
                       return false;
                  }
               }
               if(this.product.attrs.length == 1){
                   if(this.attr_id1 ==null){
                    this.showMsg('规格没有选择');
                   return false;
                  }
               }
               return true;
           },
           
           
           //规格有二维时，点击不分先后
           //选取规格，及时调整单价、总价和库存,规格一维点击了
           //attr: {attr_key,'',attr_values:[{id:123,attr_value:'',...}]}
           chooseItem1:function(attr,index,attr_id){
        	   //alert('--item1,length='+this.product.attrs.length);
        	   this.attr_key1=attr.attr_key;
        	   attr.attr_values.forEach(t=>{
        		 if(t.attr_id == attr_id) {
        			 this.attr_value1=t.attr_value;
        			
        		 }
        	  });
              this.attr_id1=attr_id;
              this.selected1=index;
              
              
             if(this.product.attrs.length == 2){
            	var target=null;
            	//二维已经选择了，需要计算价格,修复当用户先选择二维再选择一维时价格不变的BUG
                if(this.attr_id2 != null ){
                  this.product.mer_attr_price.forEach(item=> {
                        var s1=this.attr_id1+','+this.attr_id2;
                        var s2=this.attr_id2+','+this.attr_id1;
                        if( s1 == item.symbol  || s2 == item.symbol)
                        {
                            target=item;
                        }
                    });
                    
                    
                     //alert('--item1 click:'+JSON.stringify(target));
                     if(target != null){
                        this.price=target.price;
                        this.remain=target.num;
                        this.symbol=target.symbol;
                    }
                }
                
                 
             } 
             if(this.product.attrs.length == 1){
                 
                
                var target=null;
                	
                this.product.mer_attr_price.forEach(item=> {
               
                  if( attr_id == item.symbol ){
                      target=item;
                   }
               });
                
                if(target != null){
                     this.price=target.price;
                     this.remain=target.num;
                     this.symbol=target.symbol;
                }
                
                
             } 
             
              this.total_price=this.price*this.count.toFixed(2);
              //alert('kv1='+this.attr_key1+','+this.attr_value1);
           },
           
           //规格二维点击了
           chooseItem2:function(attr,index,attr_id){ 
        	//alert('--item2,length='+this.product.attrs.length);
            this.attr_id2=attr_id;
            this.selected2=index;
            if(this.attr_id1 == null ) return false;
            var target=null;
            this.attr_key2=attr.attr_key;
     	    attr.attr_values.forEach(t=>{
     		 if(t.attr_id == attr_id) {
     			 this.attr_value2=t.attr_value;
     			
     		 }
     	  });
            
            this.product.mer_attr_price.forEach(item=> {
                var s1=this.attr_id1+','+this.attr_id2;
                var s2=this.attr_id2+','+this.attr_id1;
                if( s1 == item.symbol  || s2 == item.symbol){
                    
                     target=item;
            }});
           if(target !=null ){
              this.price=target.price;
              this.remain=target.num;
              this.symbol=target.symbol;
            }  
            
            this.total_price=this.price*this.count.toFixed(2);
            //alert('kv2='+this.attr_key2+','+this.attr_value2);
         },
    	  
    	  //农斋 myDialog.vue复用结束
 
    	  //点击商品弹出详情弹窗
    	  showDetail: function(merId){
    		  
    		  //避免价格引用了上一次的价格
    		  this.price=null;
              this.price_span=null;
              this.symbol=null;
              this.count=1;
              this.selected1=-1;
              this.selected2=-1;
              this.attr_id1=null;
              this.attr_id2=null;
              this.total_price=0;
              this.attr_key1=null;
              this.attr_value1=null;
              this.attr_key2=null;
              this.attr_value2=null;
              this.label=null;
              
              
    		  this.mers.forEach(mer=>{
    			   
    			    mer.list.forEach(t=>{
    			    	
    	    			   if(t.id == merId){
    	    				   
    	    				   this.product=t;
    	    				   
    	    				  
    	    			   }
    			    });
    		   });
    		   
    		       		   
    		   //alert(JSON.stringify(this.product));
    		   this.mer_name=this.product.name;
    		   this.price=this.product.price;
    		   this.mer_img=this.product.image;
    		   this.total_price=this.price*this.count.toFixed(2);
    		   //alert(this.mer_name+","+this.mer_price+","+this.mer_img);
    		   this.mer_attrs=this.product.attrs;
    		   //alert(this.product.mer_attr_price.length);
    		   // 开始价格计算,价格区间
    		   if(this.product.mer_attr_price.length >0 ){
                   if(this.product.mer_attr_price.length==1) {
                	   this.price_span=this.product.mer_attr_price[0]['price'];
                	   return flase;
                   }
                   this.product.mer_attr_price.sort(function(a,b){
                      if(a['price']<b['price']){
                          return -1;
                      }
                      if(a['price']>b['price']){
                       return 1;
                     }
                     return 0;
                  });
                   //alert("--sort end --");
                  if(this.product.mer_attr_price[0]['price'] == this.product.mer_attr_price[this.product.mer_attr_price.length-1]['price']){
                     this.price_span=this.product.mer_attr_price[0]['price'];
                  }else{
                    this.price_span=this.product.mer_attr_price[0]['price']+'-'+this.product.mer_attr_price[this.product.mer_attr_price.length-1]['price'];
                  }
                  
                  
             }else{
             
                this.price=this.product.price;
                this.price_span=null;
                
             }
    		   
    		// 结束价格计算  
    		   
            //规格挑选窗口显示
    		$("#myModal").modal("show");
      		event.preventDefault(); 
    		   
    
    	  },
    	//提交购物车请求
          addToCart: function() {
       	   
       	    if(!this.judgeAttrComplete()){
                   return;
            }
       	    
       	    if(this.attr_key1 != null && this.attr_value1 !=null){
       	    	
       	    	this.label=this.attr_key1+":"+this.attr_value1;
       	    	
       	    	if(this.attr_key2 != null && this.attr_value2 !=null){
       	    		this.label=this.label+" "+this.attr_key2+":"+this.attr_value2;
       	    	}
       	    	
       	    }
       	    
            //alert(this.label);
            
       	    var params={};
            
       	    if(this.symbol == null){
       	    	
              params={'id':this.product.id,'count':this.count,'price':this.price};
              
            }else{
                
              if(this.label != null){
            	  params={'id':this.product.id,'symbol':this.symbol,'label':this.label,'count':this.count,'price':this.price};
              }else{
            	  params={'id':this.product.id,'symbol':this.symbol,'count':this.count,'price':this.price};
              }
              
               	   
           }
               
            //alert(JSON.stringify(params));    
            this.sendAddToCart(params);
       	   
          },
    	
    	  //加入购物车的Ajax请求
    	  sendAddToCart: function(params){
    		
      	    var jsondata=JSON.stringify(params);
      	    //alert(jsondata);
      	           var __this=this;
      	           $.ajax({
      	           type:"POST",
      	           contentType: "application/json; charset=utf-8",
                   url:this.ctxPath+"/consumer/addToCart",
      	           data:jsondata,
      	           datatype: "json",
      	           success: function (message) 
      			   {
      				   var resMsg=message.resMsg;
      				   var resCode=message.resCode;
      				   //alert("resCode="+resCode+",resMsg="+resMsg);
      				   if(resCode=='0')
      				   {
      					 __this.clearDiv('cartDiv');
      					
      		         	  $("#cartDiv").html(message.totalNum);
      		         	  __this.hideModal();
      		         	  
      				   }else{
      					 __this.showMsg(resMsg);
      				   }
      	              
      	            },
      	            
      	            error: function (message) 
      			    {
      	               
      				     this.showMsg("服务器异常");
      	            }
      	              
      	         });
      			 
        } , 
    	 //清理DIV所有节点
    	 clearDiv: function(div){ 
    	  var doc=document.getElementById(div);
    	 	 while(doc.hasChildNodes())
    	 	 {
    	 		 doc.removeChild(doc.firstChild);
    	 	 }
    	 },
    	 
        docScroll1:function () {
        	
        	var docLeft=$('#left');
            var firstLi = $('#left').find('li:first');
            var height = docLeft.height();
            
            firstLi.animate({
                height: 0   
                }, 500, function() {
                firstLi.css('height', height).appendTo(docLeft);
              
            });
        	
        },
    	 
        docScroll: function(){
        	
        		
        		
        },
    	//初始产品画布
    	resetCanvas: function() {
    		var __this=this;
    		$(window).scroll(function(){
    		  $('.right').css('margin-left',$('.left').width()+10);
    		  var sv=$(window).scrollTop();
      	      if(sv >= 850 ){
      		   
      	        $('.swiper-container-ul').css('position','fixed');
      	        $('.left').css('position','fixed');
      	        //$('.right').css('margin-left',$('.left').width());
      	      } 
      	      else
      	      {
      	    	 
      	        $('.swiper-container-ul').css('position','');
      	        $('.left').css('position','');
      	        //$('.right').css('margin-left','');
      	      }
      	      
      	      $('.right ul li').each(function(){
      	        var target = parseInt($(this).offset().top-$(window).scrollTop()-150);
      	        var i = $(this).index();
      	        if (target<=0) {
      	          $('.left ul li').removeClass('active');
      	          $('.left ul li').eq(i).addClass('active');
      	        }
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
    	 });   
    		
    	} , 
        
        
        fetchProductList: function() {
        	
            var __this=this;
            
            $.ajax({
             type:"POST",
             contentType: "application/json; charset=utf-8",
             url:this.ctxPath+"/shop/getproducts", 
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
                	 __this.leftScroll();
                	 
                   }); 
                 
  			   }
          
              },
              error: function(jqXHR, textStatus, errorThrown) 
  		      {
                 
  			     this.showMsg("请求异常"); 
              }
                
           });
       },
       
       showMsg: function(msg){
    	   
    	   $.toast({
   		    heading: '操作提示',
   		    text: msg,
   		    position: 'mid-center',
   		    stack: false
   		   });
       },
       
       
       
       hideModal: function() {
    	   
    	   $('#myModal').modal('hide');
      
       },
        
        
      },
      
      created () {
    	  
    	  
     },
     
     mounted () {
    	 
    	 
    	 this.fetchProductList();
    	 this.hideModal();
     }
      
    });
  </script>


</body>
</html>
