<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/myCartTag.tld" prefix="cart" %>
<jsp:include page="common.jsp"/>
<c:set var="shopinfo" value="${sessionScope.key_scan_shop}"/> 
<c:set var="weuser" value="${sessionScope.key_wechat_userinfo}"/>  
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
  <link rel="stylesheet" href="${ctxPath}/css/cart.css">
  
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
  
   <div style="padding:5px">
     <mt-cell title="本店WIFI名：wxdx_hotel，帐号：wxde_hotel,密码：8888666,欢迎使用!">
      <img slot="icon" src="../../images/broadcast.png">
     </mt-cell>
   </div>
 
       <!-- <cart:myCartTag></cart:myCartTag> -->
 <!--  start of cart  -->   
 <!--    
  <div class="cart">
             <input type="hidden" name="ctxPath" value="${ctxPath}">
             <input type="hidden" name="shopid" value="${shopinfo.id}">
             <input type="hidden" name="tableNo" value="${shopinfo.tableNo}">
             
        <div class="cart-header" v-show="cartList.length > 0">
            <div class="cart-header-title">购物清单</div>
            <div class="cart-header-main">
                <div class="cart-info">商品信息</div>
                <div class="cart-price">单价</div>
                <div class="cart-count">数量</div>
                <div class="cart-cost">小计</div>
                <div class="cart-delete">删除</div>
            </div>
        </div>
        <div class="cart-content">
            <div class="cart-content-main" v-for="(item, index) in cartList">
                <div class="cart-info">
                    <img :src="item.image">
                    
                </div>
                
                
                <div class="cart-price">¥ {{ item.price }}</div>
                <div class="cart-count">
                    <span class="cart-control-minus" @click="subMer(item.id,item.symbol)">-</span>
                    {{ item.count }}
                    <span class="cart-control-add" @click="addMer(item.id,item.symbol)">+</span>
                </div>
                <div class="cart-cost">¥ {{ item.price * item.count }}</div>
                <div class="cart-delete">
                    <span class="cart-control-delete" @click="delMer(item.id,item.symbol)">删除</span>
                </div>
                
                <div class="cart-extend">{{ item.name }} &nbsp;{{ item.label}}</div>
                
            
            </div>
            <div class="cart-empty" v-if="cartList.length == 0">
            
             <img src="../images/cart.png" > <br>
            亲，购物车饿瘪啦！
            
            </div>
        </div>
        
        
        <div class="cart-footer" v-show="cartList.length">
            <div class="cart-footer-desc">
                共计 <span>{{ countAll }}</span> 件商品
            </div>
            <div class="cart-footer-desc">
                应付总额 <span>¥ {{ costAll - promotion }}</span>
                <br>
                <template v-if="promotion">
                    （优惠 <span>¥ {{ promotion }}</span>）
                </template>
            </div>
            <div class="cart-footer-desc">
                <div class="cart-control-order" @click="handleOrder">现在结算</div>
            </div>
        </div>
    </div>
    -->
    <!--  end of cart  --> 
    
    <!--  start of foot  -->
  
     <mt-tabbar v-model="selected" fixed>
      <mt-tab-item>
        
        <img slot="icon" src="../../images/home.png" style="cursor:pointer;" > 
              <c:if test="${weuser.type eq 'DKDC'}">
               <a href="${ctxPath}/shop/${shopinfo.id}/${shopinfo.tableNo}/1"> 主页</a>
              </c:if>
              <c:if test="${weuser.type ne 'DKDC'}">
                 <a href="${ctxPath}/shop/${shopinfo.id}/${shopinfo.tableNo}/1">主页</a>
              </c:if>
         </img>
        
       </mt-tab-item>
       
        <mt-tab-item>
        
          <img slot="icon" src="../../images/kefu.png" style="cursor:pointer;" > 
            客服
         </img>
       
        </mt-tab-item>
        
         <mt-tab-item>
          
         <img slot="icon" src="../../images/cart_active.png" style="cursor:pointer;" > 
            	购物车
         </img>
       
          </mt-tab-item>
          
           <mt-tab-item>
         
            <img slot="icon" src="../../images/me.png" style="cursor:pointer;" > 
            	我的
            </img>
          
         
          </mt-tab-item>
    
    </mt-tabbar>
   <!--  end of foot  -->
  
  </div>
</body>
  
  <script src="${ctxPath}/js/vue.js"></script>
  <script src="${ctxPath}/js/mint-ui.js"></script>
  <script src="${ctxPath}/js/jquery.min.js"></script>
  <script src="${ctxPath}/js/json2.js"></script>
  <script>
    new Vue({
      el: '#app',
      data() {
    	
    	 return {
    		    selected: '主页',
    		    cartList: []
    	        
    	 }
    	  
      },
      methods: {
    	  
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