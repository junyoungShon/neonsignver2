<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="itjaSlide">
   <h2 class="itjaMainTitle">베스트 잇자!</h2>
   <div class="container-fluid">
      <div class="gallery js-flickity"
         data-flickity-options='{ "freeScroll": true, "wrapAround": true ,"pageDots": false}'>
         <!-- el 문 및 ajax로 베스트글이 표시되는 슬라이드 지역 -->
         <!-- 카드 1개 -->
         <c:forEach var="bestMainArticle"  items="${requestScope.bestMainArticleVOListOrderByDate}">
            <div class="card-box col-lg-2">
               <div class="card card-with-border" data-background="image"
                  data-src="${initParam.root}resources/uploadImg/articleBg/${bestMainArticle.mainArticleImgVO.mainArticleImgName}">
                  <div class="content">
                     <h6 class="category">
                         ${bestMainArticle.tagName}
                     </h6>
                     <br>
                     <c:set var="bestArticleContentTitle"
                     value="${bestMainArticle.mainArticleTitle}" />
                     <h5 class="title">
                     <!-- 카드 간격을 맞추기위해 제목을 보여주는 글자수 제한 -대협- -->
                     <c:choose>
                        <c:when test="${fn:length(bestArticleContentTitle)>12}">
                           ${fn:substring(bestArticleContentTitle, 0, 11)} ...
                        </c:when>
                        <c:otherwise>
                           ${bestArticleContentTitle}
                        </c:otherwise>
                     </c:choose>
                     </h5>
                     <c:set var="bestArticleContentContent"
                     value="${bestMainArticle.mainArticleContent}" />
                     <p class="description">
                     <!-- 카드 간격을 맞추기위해 내용을 보여주는 글자수 제한 -대협- -->
                     <c:choose>
                        <c:when test="${fn:length(bestArticleContentContent)>18}">
                        ${fn:substring(bestArticleContentContent, 0, 15)} ...
                     </c:when>
                        <c:otherwise>
                        ${bestArticleContentContent}
                     </c:otherwise>
                     </c:choose>
                     </p>
                     <a href="mypage.neon?memberEmail=${bestMainArticle.memberVO.memberEmail}" style="" tabindex="1" class="btn btn-lg btn-warning myNickDetail" role="button" 
                     data-toggle="popover" 
                     title="${bestMainArticle.memberVO.memberNickName}님, ${bestMainArticle.memberVO.rankingVO.memberGrade} PTS(${bestMainArticle.memberVO.memberPoint} / ${bestMainArticle.memberVO.rankingVO. maxPoint})" 
                     data-content="${bestMainArticle.memberVO.memberNickName}님 Click하여 페이지 보기" >
                     <span class="writersNickName">- ${bestMainArticle.memberVO.memberNickName} -</span>
                     </a>
                     <input type="hidden" class="mainArticleTitleNO bestMainArticleNo" value="${bestMainArticle.mainArticleNo}">
                     <input type="hidden" class="loginMemberEmail" value="${sessionScope.memberVO.memberEmail}">
                     <div class="actions">
                        <button class="btn btn-round btn-fill btn-neutral btn-modern"
                           data-toggle="modal" data-target="#cardDetailView">
                           Read Article</button>
                     </div>
                  </div>
                  <input type="hidden" value="${bestMainArticle.mainArticleUpdateDate}" class="updateDate" name="card${bestMainArticle}">
                  <div class="social-line social-line-visible" data-buttons="4">
                     <button class="btn btn-social btn-pinterest">
                        <span class="time_area"></span>
                     </button>
                     <button class="btn btn-social btn-twitter bestItja">
                                <c:set var="count" value="false" />
                        <c:forEach var="itjaList" items="${sessionScope.memberVO.itjaMemberList}">
                           <c:choose>
                              <c:when test="${itjaList.mainArticleNo== bestMainArticle.mainArticleNo}">
                                 <c:set var="count" value="true" />
                              </c:when>
                              <c:otherwise>
                              </c:otherwise>
                           </c:choose>
                        </c:forEach>
                        <c:choose>
                           <c:when test="${count==true}">
                              <span class="itjaCount"><i class="fa fa-link"></i><br>${bestMainArticle.mainArticleTotalLike }it</span>
                           </c:when>
                           <c:otherwise>
                              <span class="itjaCount"><i class="fa fa-chain-broken"></i><br>${bestMainArticle.mainArticleTotalLike }it</span>
                           </c:otherwise>
                        </c:choose>
                            </button>
                                <%--
                               잇자 버튼 클릭시 전달 할 정보를 위한 히든 폼
                               주제글의 잇자 클릭이므로 subArticleNo=0으로 넘어간다.
                             --%>
                     
                              
                            <form name="itJaInfo">
                               <input type="hidden" name="memberEmail" value="${sessionScope.memberVO.memberEmail}">
                               <input type="hidden" name="mainArticleNo" value="${bestMainArticle.mainArticleNo}">
                               <input type="hidden" name="subArticleNo" value=0>
                            </form>
                            <%--
                               잇자 버튼 클릭시 전달 할 정보를 위한 히든 폼 끝
                             --%>
                             
                     <button class="btn btn-social btn-google staticPick">
                           <c:set var="breakCheck" value="false"/>
                     <c:forEach var="pickCheck" items="${sessionScope.memberVO.pickedVOList}">
                     <c:choose>
                        <c:when test="${pickCheck.mainArticleNo == bestMainArticle.mainArticleNo}">
                                 <c:set var="breakCheck" value="true"/>
                               </c:when>
                               <c:otherwise>
                               </c:otherwise>
                     </c:choose>
                            </c:forEach>
                            <c:choose>
                               <c:when test="${breakCheck == true}">
                                   <span class="pickSpan"><i class="fa fa-heart"></i><br>찜!</span>
                               </c:when>
                               <c:otherwise>
                                   <span class="pickSpan"><i class="fa fa-heart-o"></i><br>찜하자!</span>
                               </c:otherwise>
                            </c:choose>
                           </button>
                        <!-- 찜 정보를 전달하기 위한 폼 시작 -->
                        <form name="pickInfo">
                           <input type="hidden" name="memberEmail" value="${sessionScope.memberVO.memberEmail}">
                           <input type="hidden" name="mainArticleNo" value="${bestMainArticle.mainArticleNo}">
                      	</form>
                        <!-- 찜 정보를 전달하기 위한 폼 끝 -->
                        
                        
                     <button class="btn btn-social btn-facebook">
                        <i class="fa fa-facebook-official"></i><br> 공유!
                     </button>
                  </div>
                  <!-- end social-line social-line-visible -->
                  <div class="filter"></div>
               </div>
               <!-- end card -->
            </div>
            <!-- card-box col-md-4 -->
         </c:forEach>
         <!--끝!! 카드 1개 -->
      </div>
      <!--  end gallery js-flickity -->
   </div>
   <!-- end container -->
</div>
<!-- end jumbotron itjaSlide -->

<!-- 끝!! el 문 및 ajax로 베스트글이 표시되는 슬라이드 지역 -->

   <!-- 태그 소트 버튼 부분 -->
      <div class="container tags-container">
      <c:forEach items="${requestScope.tagVOList}" var="tagList">
         <span>#${tagList.tagName}</span>
      </c:forEach>
      </div>
   <!--  태그 소트 버튼 끝 -->   

<div class="container">
   <!-- script.js에서 게시판 종류를 구분하기위한 hidden -대협- -->
   <input type="hidden" id="articleType" value="mainArticle">
   <h2 class="itjaMainTitle">새로운 잇자!</h2>
   <!-- 태그명을 받아 현재 선택한 태그를 표시한다. -대협 -->
   <span id="getNowTagName"></span>
   <!-- Example row of columns -->
   <div class="row newItjaList">
      <!-- *** new Main 카드 1개 -->
      
      <c:forEach var="newMainArticle" items="${requestScope.newMainArticleVOList}">
         <!-- name은 script.js에서 카드 현재 카드의 수를 구하기 위해 사용 -대협- -->
         <div class="card-box col-md-4" name="newCardBox">
            <input type="hidden" id="orderBy" value="date">
            <!-- 2015-12-08 대협추가 이미지 링크 -->
            <div class="card card-with-border" data-background="image"
               data-src="${initParam.root}resources/uploadImg/articleBg/${newMainArticle.mainArticleImgVO.mainArticleImgName}">
               <div class="content">
                  <h6 class="category">
                      ${newMainArticle.tagName}
                  </h6>
                  <br>
                  <c:set var="mainArticleContentTitle" value="${newMainArticle.mainArticleTitle}" />
                  <h5 class="title">
                     <!-- 카드 간격을 맞추기위해 제목을 보여주는 글자수 제한 -대협- -->
                     <c:choose>
                        <c:when test="${fn:length(mainArticleContentTitle)>12}">
                        ${fn:substring(mainArticleContentTitle, 0, 11)} ...
                     </c:when>
                        <c:otherwise>
                        ${newMainArticle.mainArticleTitle}
                     </c:otherwise>
                     </c:choose>
                  </h5>
                  <c:set var="mainArticleContentContent"
                     value="${newMainArticle.mainArticleContent}" />
                  <p class="description">
                  <c:choose>
                        <c:when test="${fn:length(mainArticleContentContent)>18}">
                        ${fn:substring(mainArticleContentContent, 0, 15)} ...
                     </c:when>
                        <c:otherwise>
                        ${newMainArticle.mainArticleContent}
                     </c:otherwise>
                     </c:choose></p>
                <a href="mypage.neon?memberEmail=${newMainArticle.memberVO.memberEmail}" style="" tabindex="1" class="btn btn-lg btn-warning myNickDetail" role="button" 
               data-toggle="popover" 
               title="${newMainArticle.memberVO.memberNickName}님, ${newMainArticle.memberVO.rankingVO.memberGrade} PTS(${newMainArticle.memberVO.memberPoint} / ${newMainArticle.memberVO.rankingVO. maxPoint})" 
               data-content="${newMainArticle.memberVO.memberNickName}님 Click하여 페이지 보기" >
                  <span class="writersNickName">- ${newMainArticle.memberVO.memberNickName} -</span>
               </a>
                  <input type="hidden"   class="mainArticleTitleNO" value="${newMainArticle.mainArticleNo}">
                  <input type="hidden" class="loginMemberEmail" value="${sessionScope.memberVO.memberEmail}">
                  <div class="actions">
                     <button class="btn btn-round btn-fill btn-neutral btn-modern"
                        data-toggle="modal" data-target="#cardDetailView">Read
                        Article</button>
                  </div>
               </div>
               <div class="social-line social-line-visible" data-buttons="4">
                  <button class="btn btn-social btn-pinterest">
                     새로운<br>잇자!
                  </button>
                   <button class="btn btn-social btn-twitter itja">
                                    <c:set var="count" value="false" />
                        <c:forEach var="itjaList" items="${sessionScope.memberVO.itjaMemberList}">
                           <c:choose>
                              <c:when test="${itjaList.mainArticleNo== newMainArticle.mainArticleNo}">
                                 <c:set var="count" value="true" />
                              </c:when>
                              <c:otherwise>
                              </c:otherwise>
                           </c:choose>
                        </c:forEach>
                        <c:choose>
                           <c:when test="${count==true}">
                              <span class="itjaCount"><i class="fa fa-link"></i><br>${newMainArticle.mainArticleTotalLike }it</span>
                           </c:when>
                           <c:otherwise>
                              <span class="itjaCount"><i class="fa fa-chain-broken"></i><br>${newMainArticle.mainArticleTotalLike }it</span>
                           </c:otherwise>
                        </c:choose>
                            </button>
                                <%--
                               잇자, 찜 버튼 클릭시 전달 할 정보를 위한 히든 폼
                               주제글의 잇자, 찜 클릭이므로 subArticleNo=0으로 넘어간다.
                             --%>
                            <form name="itJaInfo">
                               <input type="hidden" name="memberEmail" value="${sessionScope.memberVO.memberEmail}">
                               <input type="hidden" name="mainArticleNo" value="${newMainArticle.mainArticleNo}">
                               <input type="hidden" name="subArticleNo" value=0>
                            </form>
							     <%--
                               잇자 버튼 클릭시 전달 할 정보를 위한 히든 폼 끝
                             --%>
				<!-- 찜하기 -->
                  <button class="btn btn-social btn-google pickBtn">
                           <c:set var="breakCheck" value="false"/>
                     <c:forEach var="pickCheck" items="${sessionScope.memberVO.pickedVOList}">
                     <c:choose>
                        <c:when test="${pickCheck.mainArticleNo == newMainArticle.mainArticleNo}">
                                 <c:set var="breakCheck" value="true"/>
                               </c:when>
                               <c:otherwise>
                               </c:otherwise>
                     </c:choose>
                            </c:forEach>
                            <c:choose>
                               <c:when test="${breakCheck == true}">
                                  <span class="pickSpan"><i class="fa fa-heart"></i><br>찜!</span>
                               </c:when>
                               <c:otherwise>
                                  <span class="pickSpan"><i class="fa fa-heart-o"></i><br>찜하자!</span>
                               </c:otherwise>
                            </c:choose>
                        </button>
                        <!-- 찜 정보를 전달하기 위한 폼 시작 -->
                        <form name="pickInfo">
                           <input type="hidden" name="memberEmail" value="${sessionScope.memberVO.memberEmail}">
                           <input type="hidden" name="mainArticleNo" value="${newMainArticle.mainArticleNo}">
                      	</form>
                        <!-- 찜 정보를 전달하기 위한 폼 끝 -->
                        
                  <button class="btn btn-social btn-facebook">
                     <i class="fa fa-facebook-official"></i><br> 공유!
                  </button>
               </div>
               <!-- end social-line social-line-visible -->
               <div class="filter"></div>
            </div>
            <!-- end card -->
         </div>
         <!-- card-box col-md-4 -->
      </c:forEach>
      <!--끝!! 카드 1개 -->
   </div>
   <hr>
</div>
<!-- /container -->
