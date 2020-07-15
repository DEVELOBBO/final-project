package com.exe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.dto.BookDTO;
import com.exe.dto.CustomInfo;
import com.exe.dto.CustomerDTO;
import com.exe.dto.GymDTO;
import com.exe.dto.JjimDTO;
import com.exe.dto.NoticeDTO;
import com.exe.dto.ProductDTO;
import com.exe.dto.QnaDTO;
import com.exe.dto.ReviewDTO;

public class GypDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate; 
	}
	
	
	//*******************원도현*******************
	
	//일반유저 로그인
	public CustomerDTO getLoginReadData(String cusId) {//비밀번호 찾기
		CustomerDTO dto = sessionTemplate.selectOne("loginMapper.getLoginReadData", cusId);
		return dto;
	}
	//체육관 로그인
	public GymDTO getGymLoginReadData(String cusId) {//비밀번호 찾기
		GymDTO dto = sessionTemplate.selectOne("loginMapper.getGymLoginReadData", cusId);
		return dto;
	}
	
	//아이디 찾기
	public CustomerDTO getLoginIdReadData(Map<String, Object> hMap) {
		CustomerDTO dto = sessionTemplate.selectOne("loginMapper.getLoginIdReadData", hMap);
		return dto;
	}
	
	//회원정보 수정 (유저)
	public void updateData(CustomerDTO dto) {
		sessionTemplate.update("customerMapper.updateData", dto);
	}
	
	// 회원정보 수정(체육관)
	public void gymupdateData(GymDTO gymdto) {
		sessionTemplate.update("gymMapper.gymupdateData", gymdto);
	}
	
	//회원정보 불러오기 (유저)
	public CustomerDTO getReadData(CustomInfo info) {
		CustomerDTO dto = sessionTemplate.selectOne("customerMapper.getReadData", info);
		return dto;
	}
	
	//회원정보 불러오기 (체육관)
	public GymDTO getgymReadData(CustomInfo info) {
		GymDTO dto = sessionTemplate.selectOne("gymMapper.getgymReadData", info);
		return dto;
	}
	
	//회원정보 삭제(유저)
	public void deleteData(CustomerDTO dto) {
		sessionTemplate.delete("customerMapper.deleteData", dto);
	}
	
	// 회원정보 삭제(체육관)
	public void gymdeleteData(GymDTO dto) {
		sessionTemplate.delete("gymMapper.gymdeleteData", dto);
	}
	
	//로그인시 값이 존재하는지 확인
	public int getDataCount(String cusId) {
		int result = sessionTemplate.selectOne("loginMapper.getDataCount", cusId);
		return result;
	}
	
	// 리뷰 리스트(유저)
	public List<ReviewDTO> reviewgetList(String reviewId) {
		List<ReviewDTO> reviewlists = sessionTemplate.selectList("customerMapper.reviewgetLists", reviewId);
		return reviewlists;
	}
	
	// 리뷰 리스트(체육관)
	public List<ReviewDTO> gymreviewgetList(String reviewId) {
		List<ReviewDTO> gymreviewlists = sessionTemplate.selectList("gymMapper.gymreviewgetLists", reviewId);
		return gymreviewlists;
	}
	
	// 리뷰 삭제
	public void reviewdeleteData(int reNum) {
		sessionTemplate.delete("customerMapper.reviewdeleteData", reNum);
	}
	
	// 찜 리스트
	public List<JjimDTO> jjimgetList(String jjimId) {
		List<JjimDTO> jjimlists = sessionTemplate.selectList("customerMapper.jjimgetLists", jjimId);
		return jjimlists;
	}
	
	// 찜 삭제
	public void jjimdeleteData(String gymId) {
		sessionTemplate.delete("customerMapper.jjimdeleteData", gymId);
	}
	
	// 예약 리스트(유저)
	public List<BookDTO> bookgetList(String bookId) {
		List<BookDTO> booklists = sessionTemplate.selectList("customerMapper.bookgetLists", bookId);
		return booklists;
	}
	
	// 예약 리스트(체육관)
	public List<BookDTO> gymbookgetList(String bookId) {
		List<BookDTO> gymbooklists = sessionTemplate.selectList("gymMapper.gymbookgetLists", bookId);
		return gymbooklists;
	}
	
	// 예약 삭제
	public void bookdeleteData(int bookNum) {
		sessionTemplate.delete("customerMapper.bookdeleteData", bookNum);
	}
	
	//예약 데이터 개수
	public int bookgetDataCount(Map<String, Object> hMap) {
		int result = sessionTemplate.selectOne("gymMapper.getDataCount",hMap);
		return result;
	}
	
	
	
	
	//*******************김세이*******************
	// getGymList : 체육관 하나의 정보 받아오기
	public GymDTO getGymData(String gymId){
		GymDTO gymDto = sessionTemplate.selectOne("gymDetailMapper.getGymData", gymId);
		return gymDto;
	}

	// getReviewNumMax : 리뷰 전체의 최댓값 : 데이터 삽입시 필요
	public int getReviewNumMax() {
		int result = sessionTemplate.selectOne("gymDetailMapper.getReviewNumMax");
		return result;
	}
	
	// getReviewNum : 체육관 하나에 달린 리뷰 갯수
	public int getReviewNum(String gymId) {
		int result = sessionTemplate.selectOne("gymDetailMapper.getReviewNum", gymId);
		return result;
	}
	
	// getReviewData : 체육관 하나의 전체 리뷰 리스트 받아오기
	public List<ReviewDTO> getReviewList(Map<String, Object> hMap) {
		List<ReviewDTO> reviewLists  = sessionTemplate.selectList("gymDetailMapper.getReviewList",hMap);
		return reviewLists;
	}
	
	// insertReviewData : 리뷰 삽입
	public void insertReviewData(ReviewDTO dto) {
		sessionTemplate.insert("gymDetailMapper.insertReviewData", dto);
	}
	
	// deleteReviewData : 리뷰 삭제
	public void deleteReviewData(int reNum) {
		sessionTemplate.delete("gymDetailMapper.deleteReviewData",reNum);
	}

	// getAvgReview : 체육관 평점 평균
	public int getAvgReview(String gymId) {
		int result = sessionTemplate.selectOne("gymDetailMapper.getAvgReview", gymId);
		return result;
	}

	// getTimesCusBookedGym : 체육관 예약 횟수 확인 : 세션의 사용자의 해당 체육관 이용 횟수
	public int getTimesCusBookedGym(Map<String, Object> hMap) {
		int result = sessionTemplate.selectOne("gymDetailMapper.getTimesCusBookedGym",hMap);
		return result;
	}
	
	// getTimesCusReviewedGym : 체육관 리뷰 횟수 확인 : 세션의 사용자의 해당 체육관 리뷰 횟수
	public int getTimesCusReviewedGym(Map<String, Object> hMap) {
		int result = sessionTemplate.selectOne("gymDetailMapper.getTimesCusReviewedGym",hMap);
		return result;
	}

	// getCusPassLeft : 사용자 잔여 pass 수
	public int getCusPassLeft(String cusId) {
		int result = sessionTemplate.selectOne("gymDetailMapper.getCusPassLeft",cusId);
		return result;
	}
	
	// checkDuplicateBook : 예약 중복확인
	public int checkDuplicateBook(BookDTO checkDto) {
		int result = sessionTemplate.selectOne("gymDetailMapper.checkDuplicateBook", checkDto);
		return result;
	}

	// insertBookData : 예약 삽입
	public void insertBookData(BookDTO dto) {
		sessionTemplate.insert("gymDetailMapper.insertBookData", dto);
	}
	
	// getBookNumMax : 예약 최댓값 : 삽입에 필요
	public int getBookNumMax() {
		int result = sessionTemplate.selectOne("gymDetailMapper.getBookNumMax");
		return result;
	}

	// updateCusPass : 예약시 사용자 잔여 pass update
	public void updateCusPass(Map<String, Object> hMap) {
		sessionTemplate.update("gymDetailMapper.updateCusPass", hMap);
	}

	// countJjimData : 체육관 찜 여부 파악을 위한 찜 횟수 count
	public int countJjimData(Map<String, Object> hMap) {
		int result = sessionTemplate.selectOne("gymDetailMapper.countJjimData", hMap);
		return result;
	}

	// insertJjimData : 체육관 찜하기
	public void insertJjimData(JjimDTO dto) {
		sessionTemplate.insert("gymDetailMapper.insertJjimData", dto);
	}

	// deleteJjimData : 체육관 찜 삭제하기
	public void deleteJjimData(String gymId) {
		sessionTemplate.delete("gymDetailMapper.deleteJjimData", gymId);
	}

	// getProductListForGym : 체육관 상세페이지에 뿌릴 관련 인기 상품 품목 3가지
	public List<ProductDTO> getProductListForGym(String c) {
		List<ProductDTO> productListForGym  = sessionTemplate.selectList("gymDetailMapper.getProductListForGym",c);
		return productListForGym;
	}

	
	//*******************서예지*******************
	
	// 공지사항 최댓값
	public int getNoticeMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("notice.maxNum");
		return maxNum;
	}
	
	// 공지사항 추가
	public void insertNotice(NoticeDTO dto){
		sessionTemplate.insert("notice.insertData",dto);
	}
	
	// 공지사항 데이터 갯수
	public List<NoticeDTO> getNoticeList(int start, int end){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", start);
		params.put("end", end);
		List<NoticeDTO> lists = sessionTemplate.selectList("notice.getLists",params);
		return lists;
	}
	
	//공지사항 1개 가져오기
	public NoticeDTO getNoticeReadData(int notiNum){
		NoticeDTO dto = sessionTemplate.selectOne("notice.getReadData",notiNum);
		return dto;
	}
	
	//공지사항 이전글
	public NoticeDTO getNoticePreReadData(int notiNum){
		NoticeDTO dto = sessionTemplate.selectOne("notice.preReadData",notiNum);
		return dto;
	}
	
	//공지사항 다음글
	public NoticeDTO getNoticeNextReadData(int notiNum){
		NoticeDTO dto = sessionTemplate.selectOne("notice.nextReadData",notiNum);
		return dto;
	}
	
	// 공지사항 데이터 리스트 가져오기
	public int getNoticeDataCount(){
		int result = sessionTemplate.selectOne("notice.getDataCount");
		return result;
	}
	
	//공지사항 삭제
	public void deleteNoticeData(int notiNum){
		sessionTemplate.delete("notice.deleteData",notiNum);
	}
	
	//공지사항 수정
	public void updateNoticeData(NoticeDTO dto){
		sessionTemplate.update("notice.updateData",dto);
	}

	//-------------qna--------------------
	
	// Q&A 최댓값
	public int getQnaMaxNum(){
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("qna.maxNum");
		return maxNum;
	}
	
	// Q&A 추가
	public void insertQna(QnaDTO dto){
		sessionTemplate.insert("qna.insertData",dto);
	}
	
	// Q&A 데이터 갯수
	public List<QnaDTO> getQnaList(int start, int end,String searchKey,String searchValue){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		List<QnaDTO> lists = sessionTemplate.selectList("qna.getLists",params);
		return lists;
	}
	
	//Q&A 데이터 1개
	public QnaDTO getQnaReadData(int qnaNum){
		QnaDTO dto = sessionTemplate.selectOne("qna.getReadData",qnaNum);
		return dto;
	}
	
	//Q&A 이전글
	public QnaDTO getQnaPreReadData(int qnaNum,String searchKey,String searchValue){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("qnaNum", qnaNum);
		
		QnaDTO dto = sessionTemplate.selectOne("qna.preReadData",params);
		return dto;
	}

	//Q&A 다음글
	public QnaDTO getQnaNextReadData(int qnaNum,String searchKey,String searchValue){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("qnaNum", qnaNum);
		
		QnaDTO dto = sessionTemplate.selectOne("qna.nextReadData",params);
		return dto;
	}
	
	// Q&A 데이터 갯수 가져오기
	public int getQnaDataCount(String searchKey,String searchValue){
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put("searchKey", searchKey);
			params.put("searchValue", searchValue);
			int result = sessionTemplate.selectOne("qna.getDataCount",params);
			return result;
		}

	//orderNo 정렬
	public void orderNoUpdate(String qnaGroupNum,String qnaOrderNo) {
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("qnaGroupNum", qnaGroupNum);
		params.put("qnaOrderNo", qnaOrderNo);
		sessionTemplate.update("qna.orderNoUpdate",params);
	}
	
	//QnA삭제
	public void deleteQnaData(int qnaNum){
		sessionTemplate.delete("qna.deleteData",qnaNum);
	}
	
	//QnA수정
	public void updateQnaData(QnaDTO dto){
		sessionTemplate.update("qna.updateData",dto);
	}
	
	//*******************채종완*******************
	 
	//cusCreated : 개인회원가입정보 삽입
	public void cusCreated(CustomerDTO dto) {
		sessionTemplate.insert("createMapper.insertCus",dto);
	}
	
	// gymCreated : 체육관 회원가입정보 삽입
	public void gymCreated(GymDTO dto) {
		sessionTemplate.insert("createMapper.insertGym",dto);
	}
	
	//아이디 체크
	public void idCheck(CustomerDTO dto) {
		sessionTemplate.selectOne("createMapper.idCheck", dto);
	}
	
	
	//*******************최보경*******************
	
	//로그인한 회원의 주소 가져오기
	public String getCusAddr(String sessionId) {
		String customerAddr = sessionTemplate.selectOne("recommend.customerAddr", sessionId);
		return customerAddr;
	}
	
	//회원 주소를 기반으로 메인화면에서 체육관 추천 
	public List<GymDTO> getGymRecommend(String customerAddr){
		List<GymDTO> nearGymLists = sessionTemplate.selectList("recommend.nearGymList", customerAddr);
		return nearGymLists;
	}
	
	//로그인하지 않은 화면에서 체육관 추천
	public List<GymDTO> getGymRecommendDefault(){
		List<GymDTO> nearGymDefaultLists = sessionTemplate.selectList("recommend.nearGymDefaultLists");
		return nearGymDefaultLists;
	}

	//최신 예약한 체육관 타입 추출
	public String getCusRecentBookType(String sessionId) {
		String gymType = sessionTemplate.selectOne("recommend.customerRecentBookType", sessionId);
		return gymType;
	}
	
	//최신 예약을 기반으로 메인화면에서 제품 추천
	public List<ProductDTO> getProductRecommend(String productType) {
		List<ProductDTO> productRecommendLists = sessionTemplate.selectList("recommend.productRecommend", productType);
		return productRecommendLists;
	}
	
	//로그인 하지 않은 화면에서 제품추천
	public List<ProductDTO> getProductRecommendDefault() {
		List<ProductDTO> productRecommendLists = sessionTemplate.selectList("recommend.productRecommendDefault");
		return productRecommendLists;
	}


	// *******************경기민*******************
	// 체육관 검색
	public List<GymDTO> getMapList(int start, int end, String searchKey, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		List<GymDTO> lists = sessionTemplate.selectList("mapMapper.getMapList", params);
		return lists;
	}

	// 체육관의 갯수
	public int getMapDataCount(String searchKey, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		int result = sessionTemplate.selectOne("mapMapper.getMapDataCount", params);
		return result;
	}

	// 이름 검색어 추천(DB 내용 기반)
	public List<GymDTO> getSearchName(int start, int end, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchValue", searchValue);
		List<GymDTO> lists = sessionTemplate.selectList("mapMapper.getSearchName", params);
		return lists;
	}

	// 지역 검색어 추천(DB 내용 기반)
	public List<GymDTO> getSearchGoo(int start, int end, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchValue", searchValue);
		List<GymDTO> lists = sessionTemplate.selectList("mapMapper.getSearchGoo", params);

		return lists;
	}

	// 종목 검색어 추천(DB 내용 기반)
	public List<GymDTO> getSearchType(int start, int end, String searchValue) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchValue", searchValue);
		List<GymDTO> lists = sessionTemplate.selectList("mapMapper.getSearchType", params);
		return lists;
	}
	
	// 회원 주소 정보로 검색(DB 내용 기반)
	public CustomerDTO getCustomerGoo(String sessionId) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("sessionId", sessionId);
		CustomerDTO dto = sessionTemplate.selectOne("mapMapper.getCustomerGoo", params);
		return dto;
	}
	
	// *******************최원식*******************

	// 체육관 리스트 갯수
	public int gymGetDataCount(String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		int result = sessionTemplate.selectOne("adminGymMapper.getDataCount", params);

		return result;
	}

	// 체육관 리스트
	public List<GymDTO> gymGetList(int start, int end, String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);

		List<GymDTO> lists = sessionTemplate.selectList("adminGymMapper.getLists", params);

		return lists;
	}

	// 체육관 미승인 리스트
	public List<GymDTO> gymGetFalseList() {
		List<GymDTO> falselists = sessionTemplate.selectList("adminGymMapper.getFalseLists");
		return falselists;
	}

	//체육관 gymOk false -> true
	public void gymUpdateData(GymDTO dto) {
		sessionTemplate.update("adminGymMapper.updateData", dto);
	}

	// 체육관 삭제
	public void gymDeleteData(String str) {
		sessionTemplate.delete("adminGymMapper.deleteData", str);
	}

	// 회원 수
	public int customerGetDataCount(String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		int result = sessionTemplate.selectOne("adminCustomerMapper.getDataCount", params);

		return result;
	}

	// 회원 리스트
	public List<CustomerDTO> customerGetList(int start, int end, String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);

		List<CustomerDTO> lists = sessionTemplate.selectList("adminCustomerMapper.getLists", params);

		return lists;
	}

	// 고객 불러오기 (조회)
	public CustomerDTO customerGetReadData(int num) {
		CustomerDTO dto = sessionTemplate.selectOne("adminCustomerMapper.getReadData", num);
		return dto;
	}

	// 고객 데이터 삭제
	public void customerDeleteData(String str) {
		sessionTemplate.delete("adminCustomerMapper.deleteData", str);
	}

	// 공지사항 maxNum
	public int noticeMaxNum() {
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("adminNoticeMapper.maxNum");
		return maxNum;
	}

	// 공지사항 생성
	public void noticeInsertData(NoticeDTO dto) {

		sessionTemplate.insert("adminNoticeMapper.insertData", dto);

	}

	// 공지사항 리스트
	public List<NoticeDTO> noticeGetList(int start, int end) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);

		List<NoticeDTO> lists = sessionTemplate.selectList("adminNoticeMapper.getLists", params);
		return lists;
	}

	// 공지사항 갯수
	public int noticeGetDataCount() {
		int result = sessionTemplate.selectOne("adminNoticeMapper.getDataCount");
		return result;
	}

	// 공지사항 불러오기 (조회)
	public NoticeDTO noticeGetReadData(int num) {
		NoticeDTO dto = sessionTemplate.selectOne("adminNoticeMapper.getReadData", num);
		return dto;
	}

	// 공지사항 수정
	public void noticeUpdateData(NoticeDTO dto) {
		sessionTemplate.update("adminNoticeMapper.updateData", dto);
	}

	// 공지사항 삭제
	public void noticeDeleteData(int num) {
		sessionTemplate.delete("adminNoticeMapper.deleteData", num);
	}

	// 상품관리 상품 갯수
	public int productGetDataCount(String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		int result = sessionTemplate.selectOne("adminProductMapper.getDataCount", params);
		return result;
	}

	// 상품 생성, 입력
	public void productInsertData(ProductDTO dto) {
		sessionTemplate.insert("adminProductMapper.insertData", dto);
	}

	// 상품 리스트
	public List<ProductDTO> productGetList(int start, int end, String searchKey, String searchValue) {

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);

		List<ProductDTO> lists = sessionTemplate.selectList("adminProductMapper.getLists", params);

		return lists;

	}

	// 상품 불러오기 (조회)
	public ProductDTO productGetReadData(String str) {
		ProductDTO dto = sessionTemplate.selectOne("adminProductMapper.getReadData", str);
		return dto;
	}

	// 상품 조회수
	public void productUpdateHitCount(int num) {
		sessionTemplate.update("adminProductMapper.updateHitCount", num);
	}

	// 상품 수정
	public void productUpdateData(ProductDTO dto) {
		sessionTemplate.update("adminProductMapper.updateData", dto);
	}

	// 상품 삭제
	public void productDeleteData(String str) {
			sessionTemplate.delete("adminProductMapper.deleteData", str);
		}

}

























