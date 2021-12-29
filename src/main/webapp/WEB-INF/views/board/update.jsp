<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" href="/resources/css/common.css" />
        <link rel="stylesheet" href="/resources/css/approval.css" />
        <link rel="stylesheet" href="/resources/css/style.min.css" />
        <link rel="stylesheet" href="/resources/css/jquery.mCustomScrollbar.min.css" />
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="/resources/js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="/resources/js/intra.js"></script>
        <script src="/resources/js/tui-date-picker.js"></script>
        <script src="/resources/js/tui-time-picker.js"></script>
        <script type="text/javascript" src="/resources/SE2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
        <title>intranet</title>
        <style>
        	.rnoColumn{display: none;}#ModBtn,#RemoveBtn{cursor: pointer;}.modInput{border:1px solid #333;margin:5px 0;outline:none;}.blindBtn{display:none;cursor: pointer;color:#777;font-size:.75rem;}
        </style>
        <script>
			function save(){
				oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
				var content = document.getElementById("smartEditor").value;
				return; 
			}
		</script>
    </head>
    <body>
        <div class="wrap">
            <!-- 헤더 영역 -->
             <header class="header">
                <h1>
                    <a href="/board/list" title="게임덱스 홈" style="font-size:40px;text-align:center;">
                        로고
                    </a>
                </h1>
                <div class="box">
                <div  style="position:relative;">
                   <p>
                       <strong><span>000&nbsp</span></strong><span>님&nbsp&nbsp&nbsp&nbsp</span>
                       <em>3등급</em>
                   </p>
                    <p style="position:absolute;top:0;right:-307px;"><a href="javascript:void(0);" title="로그아웃">로그아웃</a></p>
                </div>    
                     
                    <ul class="fast-menu">
                        <li><a class="fast-menu__el-1" href="javascript:void(0);" title=""></a></li>
                        <li><a class="fast-menu__el-2" href="javascript:void(0);" title=""></a></li>
                    </ul>
                </div>
            </header>
            <!-- 네비게이션 영역 -->
            <div class="navWrap">
                <ul class="nav">
                    <li class="nav_el">
                        <h4><a href="javascript:void(0);" title="전체 게시판">전체 게시판</a><i></i></h4>
                        <div class="sub_el">
                            <ul>
                              	<li>
                                    <a href="http://localhost:8080/board/elist?cate=0" title="공지사항">공지사항</a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=1" title="1등급 게시판"> 1등급 게시판 </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=2" title="2등급 게시판"> 2등급 게시판 </a>
                                </li>
                                <li>
                                    <a href="http://localhost:8080/board/elist?cate=3" title="3등급 게시판"> 3등급 게시판 </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav_el">
                        <h4><a href="javascript:void(0);" title="마이페이지">마이페이지</a><i></i></h4>
                        <div class="sub_el">
                            <ul>
                                <li>
                                    <a href="#" title="개인정보"> 개인정보 </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- 컨텐츠 영역 -->
            <div class="containers">
             <form role='form' method="post" action="update">
            	<div>
		            <div>
		            	<h2 style="margin-bottom: 30px;">1등급 게시판</h2>
		            	 <table>
		            	 	<tr><th style="width: 100px;">작성자</th><td style="width: 90%;" colspan='3'>user</td></tr>
		            	 	<tr><th style="width: 10%;">카테고리</th>
		            	 				<td style="display:none;">
			            	 				<select class="cate">					
										       <option>카테고리</option>
										       <option>카테고리</option>
										       <option>카테고리</option>
										       <option>카테고리</option>
										    </select>
		            	 				</td>
		            	 	<td style="width: 30%;" colspan='3'>1등급</td><th style="display:none;">게시일</th><td style="display:none;"> 
		            	 			<div class="tui">
			                            <div class="tui-box">
			                                <div class="tui-tit">게재 일시(KST) :</div>
			                                <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
			                                    <input type="text" id="start-date-picker-target" aria-label="Date-Time" autocomplete="off" />
			                                    <span class="tui-ico-date"></span>
			                                </div>
			                                <div id="start-date-picker-container">
			                                    <div class="tui-datepicker tui-hidden tui-rangepicker">
			                                        <div class="tui-datepicker-body tui-datepicker-type-date">
			                                            <div class="tui-calendar-container">
			                                                <div class="tui-calendar">
			                                                    <div class="tui-calendar-header">
			                                                        <div class="tui-calendar-header-inner">
			                                                            <button class="tui-calendar-btn tui-calendar-btn-prev-month tui-hidden">Prev month</button> <em class="tui-calendar-title tui-calendar-title-month">August 2021</em>
			                                                            <button class="tui-calendar-btn tui-calendar-btn-next-month">Next month</button>
			                                                        </div>
			                                                        <div class="tui-calendar-header-info"><p class="tui-calendar-title-today">Today: Thursday, September 2, 2021</p></div>
			                                                    </div>
			                                                    <div class="tui-calendar-body">
			                                                        <table class="tui-calendar-body-inner" cellspacing="0" cellpadding="0">
			                                                            <caption>
			                                                                <span>Dates</span>
			                                                            </caption>
			                                                            <thead class="tui-calendar-body-header">
			                                                                <tr>
			                                                                    <th class="tui-sun" scope="col">Sun</th>
			                                                                    <th scope="col">Mon</th>
			                                                                    <th scope="col">Tue</th>
			                                                                    <th scope="col">Wed</th>
			                                                                    <th scope="col">Thu</th>
			                                                                    <th scope="col">Fri</th>
			                                                                    <th class="tui-sat" scope="col">Sat</th>
			                                                                </tr>
			                                                            </thead>
			                                                            <tbody>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-blocked" data-timestamp="1627743600000">1</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1627830000000">2</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1627916400000">3</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628002800000">4</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628089200000">5</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628175600000">6</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-blocked" data-timestamp="1628262000000">7</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-blocked" data-timestamp="1628348400000">8</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628434800000">9</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628521200000">10</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628607600000">11</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628694000000">12</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628780400000">13</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-blocked" data-timestamp="1628866800000">14</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-blocked" data-timestamp="1628953200000">15</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1629039600000">16</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1629126000000">17</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1629212400000">18</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable tui-is-selected" data-timestamp="1629298800000">19</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629385200000">20</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-selectable" data-timestamp="1629471600000">21</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-selectable" data-timestamp="1629558000000">22</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629644400000">23</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629730800000">24</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629817200000">25</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629903600000">26</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629990000000">27</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-selectable" data-timestamp="1630076400000">28</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-selectable" data-timestamp="1630162800000">29</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1630249200000">30</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1630335600000">31</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630422000000">1</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-today tui-is-selectable" data-timestamp="1630508400000">2</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630594800000">3</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable" data-timestamp="1630681200000">4</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-sun tui-is-selectable" data-timestamp="1630767600000">5</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630854000000">6</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630940400000">7</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1631026800000">8</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1631113200000">9</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1631199600000">10</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable" data-timestamp="1631286000000">11</td>
			                                                                </tr>
			                                                            </tbody>
			                                                        </table>
			                                                    </div>
			                                                </div>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                                <div id="start-time-picker">
			                                    <div class="tui-timepicker">
			                                        <div class="tui-timepicker-body">
			                                            <div class="tui-timepicker-row">
			                                                <div class="tui-timepicker-column tui-timepicker-selectbox tui-timepicker-hour">
			                                                    <select class="tui-timepicker-select" aria-label="Time">
			                                                        <option value="0">0</option>
			                                                        <option value="1">1</option>
			                                                        <option value="2">2</option>
			                                                        <option value="3">3</option>
			                                                        <option value="4">4</option>
			                                                        <option value="5">5</option>
			                                                        <option value="6">6</option>
			                                                        <option value="7">7</option>
			                                                        <option value="8">8</option>
			                                                        <option value="9">9</option>
			                                                        <option value="10">10</option>
			                                                        <option value="11">11</option>
			                                                        <option value="12">12</option>
			                                                        <option value="13">13</option>
			                                                        <option value="14" selected="">14</option>
			                                                        <option value="15">15</option>
			                                                        <option value="16">16</option>
			                                                        <option value="17">17</option>
			                                                        <option value="18">18</option>
			                                                        <option value="19">19</option>
			                                                        <option value="20">20</option>
			                                                        <option value="21">21</option>
			                                                        <option value="22">22</option>
			                                                        <option value="23">23</option>
			                                                    </select>
			                                                </div>
			                                                <span class="tui-timepicker-column tui-timepicker-colon"><span class="tui-ico-colon">:</span></span>
			                                                <div class="tui-timepicker-column tui-timepicker-selectbox tui-timepicker-minute">
			                                                    <select class="tui-timepicker-select" aria-label="Time">
			                                                        <option value="0">0</option>
			                                                        <option value="1">1</option>
			                                                        <option value="2">2</option>
			                                                        <option value="3">3</option>
			                                                        <option value="4">4</option>
			                                                        <option value="5">5</option>
			                                                        <option value="6">6</option>
			                                                        <option value="7">7</option>
			                                                        <option value="8">8</option>
			                                                        <option value="9">9</option>
			                                                        <option value="10">10</option>
			                                                        <option value="11">11</option>
			                                                        <option value="12">12</option>
			                                                        <option value="13">13</option>
			                                                        <option value="14">14</option>
			                                                        <option value="15">15</option>
			                                                        <option value="16">16</option>
			                                                        <option value="17">17</option>
			                                                        <option value="18">18</option>
			                                                        <option value="19">19</option>
			                                                        <option value="20">20</option>
			                                                        <option value="21">21</option>
			                                                        <option value="22">22</option>
			                                                        <option value="23">23</option>
			                                                        <option value="24">24</option>
			                                                        <option value="25">25</option>
			                                                        <option value="26">26</option>
			                                                        <option value="27">27</option>
			                                                        <option value="28">28</option>
			                                                        <option value="29">29</option>
			                                                        <option value="30">30</option>
			                                                        <option value="31">31</option>
			                                                        <option value="32">32</option>
			                                                        <option value="33">33</option>
			                                                        <option value="34">34</option>
			                                                        <option value="35">35</option>
			                                                        <option value="36">36</option>
			                                                        <option value="37">37</option>
			                                                        <option value="38">38</option>
			                                                        <option value="39">39</option>
			                                                        <option value="40">40</option>
			                                                        <option value="41">41</option>
			                                                        <option value="42">42</option>
			                                                        <option value="43">43</option>
			                                                        <option value="44">44</option>
			                                                        <option value="45">45</option>
			                                                        <option value="46">46</option>
			                                                        <option value="47">47</option>
			                                                        <option value="48">48</option>
			                                                        <option value="49">49</option>
			                                                        <option value="50">50</option>
			                                                        <option value="51" selected="">51</option>
			                                                        <option value="52">52</option>
			                                                        <option value="53">53</option>
			                                                        <option value="54">54</option>
			                                                        <option value="55">55</option>
			                                                        <option value="56">56</option>
			                                                        <option value="57">57</option>
			                                                        <option value="58">58</option>
			                                                        <option value="59">59</option>
			                                                    </select>
			                                                </div>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
		            	 				
		            	 				<div style="display:none;" class="tui-box">
			                                <div class="tui-tit">종료 일시(KST) :</div>
			                                <div class="tui-datepicker-input tui-datetime-input tui-has-focus">
			                                    <input type="text" id="end-date-picker-target" aria-label="Date-Time" autocomplete="off" />
			                                    <span class="tui-ico-date"></span>
			                                </div>
			                                <div id="end-date-picker-container">
			                                    <div class="tui-datepicker tui-hidden tui-rangepicker">
			                                        <div class="tui-datepicker-body tui-datepicker-type-date">
			                                            <div class="tui-calendar-container">
			                                                <div class="tui-calendar">
			                                                    <div class="tui-calendar-header">
			                                                        <div class="tui-calendar-header-inner">
			                                                            <button class="tui-calendar-btn tui-calendar-btn-prev-month tui-hidden">Prev month</button> <em class="tui-calendar-title tui-calendar-title-month">August 2021</em>
			                                                            <button class="tui-calendar-btn tui-calendar-btn-next-month">Next month</button>
			                                                        </div>
			                                                        <div class="tui-calendar-header-info"><p class="tui-calendar-title-today">Today: Thursday, September 2, 2021</p></div>
			                                                    </div>
			                                                    <div class="tui-calendar-body">
			                                                        <table class="tui-calendar-body-inner" cellspacing="0" cellpadding="0">
			                                                            <caption>
			                                                                <span>Dates</span>
			                                                            </caption>
			                                                            <thead class="tui-calendar-body-header">
			                                                                <tr>
			                                                                    <th class="tui-sun" scope="col">Sun</th>
			                                                                    <th scope="col">Mon</th>
			                                                                    <th scope="col">Tue</th>
			                                                                    <th scope="col">Wed</th>
			                                                                    <th scope="col">Thu</th>
			                                                                    <th scope="col">Fri</th>
			                                                                    <th class="tui-sat" scope="col">Sat</th>
			                                                                </tr>
			                                                            </thead>
			                                                            <tbody>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-blocked" data-timestamp="1627743600000">1</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1627830000000">2</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1627916400000">3</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628002800000">4</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628089200000">5</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628175600000">6</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-blocked" data-timestamp="1628262000000">7</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-blocked" data-timestamp="1628348400000">8</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628434800000">9</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628521200000">10</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628607600000">11</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628694000000">12</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1628780400000">13</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-blocked" data-timestamp="1628866800000">14</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-blocked" data-timestamp="1628953200000">15</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1629039600000">16</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1629126000000">17</td>
			                                                                    <td class="tui-calendar-date tui-is-blocked" data-timestamp="1629212400000">18</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable tui-is-selected tui-is-selected-range" data-timestamp="1629298800000">19</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629385200000">20</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-selectable" data-timestamp="1629471600000">21</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-selectable" data-timestamp="1629558000000">22</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629644400000">23</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629730800000">24</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629817200000">25</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629903600000">26</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1629990000000">27</td>
			                                                                    <td class="tui-calendar-date tui-calendar-sat tui-is-selectable" data-timestamp="1630076400000">28</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-sun tui-is-selectable" data-timestamp="1630162800000">29</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1630249200000">30</td>
			                                                                    <td class="tui-calendar-date tui-is-selectable" data-timestamp="1630335600000">31</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630422000000">1</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-today tui-is-selectable" data-timestamp="1630508400000">2</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630594800000">3</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable" data-timestamp="1630681200000">4</td>
			                                                                </tr>
			                                                                <tr class="tui-calendar-week">
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-sun tui-is-selectable" data-timestamp="1630767600000">5</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630854000000">6</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1630940400000">7</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1631026800000">8</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1631113200000">9</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-is-selectable" data-timestamp="1631199600000">10</td>
			                                                                    <td class="tui-calendar-date tui-calendar-next-month tui-calendar-sat tui-is-selectable" data-timestamp="1631286000000">11</td>
			                                                                </tr>
			                                                            </tbody>
			                                                        </table>
			                                                    </div>
			                                                </div>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                                <div id="end-time-picker">
			                                    <div class="tui-timepicker">
			                                        <div class="tui-timepicker-body">
			                                            <div class="tui-timepicker-row">
			                                                <div class="tui-timepicker-column tui-timepicker-selectbox tui-timepicker-hour">
			                                                    <select class="tui-timepicker-select" aria-label="Time">
			                                                        <option value="0">0</option>
			                                                        <option value="1">1</option>
			                                                        <option value="2">2</option>
			                                                        <option value="3">3</option>
			                                                        <option value="4">4</option>
			                                                        <option value="5">5</option>
			                                                        <option value="6">6</option>
			                                                        <option value="7">7</option>
			                                                        <option value="8">8</option>
			                                                        <option value="9">9</option>
			                                                        <option value="10">10</option>
			                                                        <option value="11">11</option>
			                                                        <option value="12">12</option>
			                                                        <option value="13">13</option>
			                                                        <option value="14" selected="">14</option>
			                                                        <option value="15">15</option>
			                                                        <option value="16">16</option>
			                                                        <option value="17">17</option>
			                                                        <option value="18">18</option>
			                                                        <option value="19">19</option>
			                                                        <option value="20">20</option>
			                                                        <option value="21">21</option>
			                                                        <option value="22">22</option>
			                                                        <option value="23">23</option>
			                                                    </select>
			                                                </div>
			                                                <span class="tui-timepicker-column tui-timepicker-colon"><span class="tui-ico-colon">:</span></span>
			                                                <div class="tui-timepicker-column tui-timepicker-selectbox tui-timepicker-minute">
			                                                    <select class="tui-timepicker-select" aria-label="Time">
			                                                        <option value="0">0</option>
			                                                        <option value="1">1</option>
			                                                        <option value="2">2</option>
			                                                        <option value="3">3</option>
			                                                        <option value="4">4</option>
			                                                        <option value="5">5</option>
			                                                        <option value="6">6</option>
			                                                        <option value="7">7</option>
			                                                        <option value="8">8</option>
			                                                        <option value="9">9</option>
			                                                        <option value="10">10</option>
			                                                        <option value="11">11</option>
			                                                        <option value="12">12</option>
			                                                        <option value="13">13</option>
			                                                        <option value="14">14</option>
			                                                        <option value="15">15</option>
			                                                        <option value="16">16</option>
			                                                        <option value="17">17</option>
			                                                        <option value="18">18</option>
			                                                        <option value="19">19</option>
			                                                        <option value="20">20</option>
			                                                        <option value="21">21</option>
			                                                        <option value="22">22</option>
			                                                        <option value="23">23</option>
			                                                        <option value="24">24</option>
			                                                        <option value="25">25</option>
			                                                        <option value="26">26</option>
			                                                        <option value="27">27</option>
			                                                        <option value="28">28</option>
			                                                        <option value="29">29</option>
			                                                        <option value="30">30</option>
			                                                        <option value="31">31</option>
			                                                        <option value="32">32</option>
			                                                        <option value="33">33</option>
			                                                        <option value="34">34</option>
			                                                        <option value="35">35</option>
			                                                        <option value="36">36</option>
			                                                        <option value="37">37</option>
			                                                        <option value="38">38</option>
			                                                        <option value="39">39</option>
			                                                        <option value="40">40</option>
			                                                        <option value="41">41</option>
			                                                        <option value="42">42</option>
			                                                        <option value="43">43</option>
			                                                        <option value="44">44</option>
			                                                        <option value="45">45</option>
			                                                        <option value="46">46</option>
			                                                        <option value="47">47</option>
			                                                        <option value="48">48</option>
			                                                        <option value="49">49</option>
			                                                        <option value="50">50</option>
			                                                        <option value="51">51</option>
			                                                        <option value="52">52</option>
			                                                        <option value="53" selected="">53</option>
			                                                        <option value="54">54</option>
			                                                        <option value="55">55</option>
			                                                        <option value="56">56</option>
			                                                        <option value="57">57</option>
			                                                        <option value="58">58</option>
			                                                        <option value="59">59</option>
			                                                    </select>
			                                                </div>
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
		            	 			</div>
								</td>
		            	 	</tr>
		            	 	<tr style="display:none;"><td><input type="hidden" name="bno" id="bno"  value='${update.bno}' ></td></tr>
		            	 	<tr><th>제목</th><td colspan='3'><input type="text" id="title" name="title" value="${update.title}" style="outline:none;width: 600px;border: 1px solid #ababab;" placeholder="제목을 입력해주세요." />  
		            	 			<span style="display: none;">
                                        <input type="checkbox" id="fixedTop" name="" />
                                        <label for="fixedTop">상단 고정 <i class="checkbox"></i></label>
                                    </span></td></tr>
		            	 	<tr style="height:200px">
		            	 		<th>내용</th>
			            	 	<td colspan='3'>
			            	 		<textarea id="txtContent" name="text" rows="10" cols="100" style="width: 100%;">${update.text}</textarea>
			            	 		<script id="smartEditor" type="text/javascript"> 
										var oEditors = [];
										nhn.husky.EZCreator.createInIFrame({
										    oAppRef: oEditors,
										    elPlaceHolder: "txtContent",  //textarea ID 입력
										    sSkinURI: "/resources/SE2/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
										    fCreator: "createSEditor2",
										    htParams : { 
										    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
										        bUseToolbar : true, 
												// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
												bUseVerticalResizer : false, 
												// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
												bUseModeChanger : false ,
											}
										});
									</script>
			            	 	</td>
			            	 </tr>
		            	 	 <tr><th>첨부파일</th><td colspan='3'><input type="file"></td></tr>
		            	 	 <tr><th>첨부파일</th><td colspan='3'><input type="file"></td></tr>
		            	</table>
	            	 </div>
	       	    	 <div>
	                    <button type="submit" class="button" style="position:absolute;bottom:-30px;right: 80px;" onclick="save()">등록</button>
	                    <div><a class="button" href="/board/list" style="position:absolute;bottom:-30px;right: 30px;">취소</a></div>
	                 </div>
                	</div>
                </form>
            </div>
        </div>
        <script>
	  	  $("button[type='submit']").on("click",function(e){
		      		var title=$("#title").val();
					var text=$("#txtContent").val();
					
				   	if(title.length==0){
						alert("제목을 입력해주세요.");
						return false;
					} else if(text.length==0 || text==' ' || text=='<p>&nbsp;</p>' || text=='<p><br></p>'){
						alert("내용을 입력해주세요.");
						return false;
					}
				 });
	      var datePicker;
          var sTimepicker;
          var eTimepicker;

          var sDateObj = new Date();
          var eDateObj = new Date();

          document.addEventListener('DOMContentLoaded', function () {
              datePicker = new tui.DatePicker.createRangePicker({
                  startpicker: {
                      date: sDateObj,
                      input: '#start-date-picker-target',
                      container: '#start-date-picker-container',
                  },
                  endpicker: {
                      date: eDateObj,
                      input: '#end-date-picker-target',
                      container: '#end-date-picker-container',
                  },
                  selectableRanges: [[sDateObj, new Date(2099, 0, 1)]],
                  
                  
              });

              sTimepicker = new tui.TimePicker('#start-time-picker', {
                  inputType: 'selectbox',
                  showMeridiem: false,
                  initialHour: sDateObj.getHours(),
                  initialMinute: sDateObj.getMinutes(),
              });

              eTimepicker = new tui.TimePicker('#end-time-picker', {
                  inputType: 'selectbox',
                  showMeridiem: false,
                  initialHour: eDateObj.getHours(),
                  initialMinute: eDateObj.getMinutes(),
              });
          });
      </script>
    </body>
</html>
