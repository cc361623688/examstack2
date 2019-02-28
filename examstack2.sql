-- MySQL dump 10.13  Distrib 5.5.40, for Win64 (x86)
--
-- Host: localhost    Database: examstack
-- ------------------------------------------------------
-- Server version	5.5.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `et_comment`
--

DROP TABLE IF EXISTS `et_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_comment` (
  `comment_id` int(10) NOT NULL AUTO_INCREMENT,
  `refer_id` int(10) NOT NULL,
  `comment_type` tinyint(1) NOT NULL DEFAULT '0',
  `index_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `content_msg` mediumtext NOT NULL,
  `quoto_id` int(10) NOT NULL DEFAULT '0',
  `re_id` int(10) NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `fk_u_id` (`user_id`),
  CONSTRAINT `et_comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_comment`
--

LOCK TABLES `et_comment` WRITE;
/*!40000 ALTER TABLE `et_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_department`
--

DROP TABLE IF EXISTS `et_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_department` (
  `dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(200) NOT NULL,
  `memo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_department`
--

LOCK TABLES `et_department` WRITE;
/*!40000 ALTER TABLE `et_department` DISABLE KEYS */;
INSERT INTO `et_department` VALUES (2,'宁夏路桥','宁夏路桥');
/*!40000 ALTER TABLE `et_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_exam`
--

DROP TABLE IF EXISTS `et_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(100) NOT NULL,
  `exam_subscribe` varchar(500) DEFAULT NULL,
  `exam_type` tinyint(4) NOT NULL COMMENT '公有、私有、模拟考试',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `exam_paper_id` int(11) NOT NULL,
  `creator` int(11) DEFAULT NULL,
  `creator_id` varchar(50) DEFAULT NULL,
  `approved` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_exam_2pid` (`exam_paper_id`),
  CONSTRAINT `fk_exam_2pid` FOREIGN KEY (`exam_paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_exam`
--

LOCK TABLES `et_exam` WRITE;
/*!40000 ALTER TABLE `et_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_exam_2_paper`
--

DROP TABLE IF EXISTS `et_exam_2_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_exam_2_paper` (
  `exam_id` int(11) NOT NULL,
  `paper_id` int(11) NOT NULL,
  UNIQUE KEY `idx_exam_epid` (`exam_id`,`paper_id`),
  KEY `fk_exam_pid` (`paper_id`),
  CONSTRAINT `fk_exam_eid` FOREIGN KEY (`exam_id`) REFERENCES `et_exam` (`id`),
  CONSTRAINT `fk_exam_pid` FOREIGN KEY (`paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_exam_2_paper`
--

LOCK TABLES `et_exam_2_paper` WRITE;
/*!40000 ALTER TABLE `et_exam_2_paper` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_exam_2_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_exam_paper`
--

DROP TABLE IF EXISTS `et_exam_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_exam_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  `paper_type` varchar(40) NOT NULL DEFAULT '1' COMMENT '0 真题 1 模拟 2 专家',
  `field_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_exam_paper`
--

LOCK TABLES `et_exam_paper` WRITE;
/*!40000 ALTER TABLE `et_exam_paper` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_exam_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_field`
--

DROP TABLE IF EXISTS `et_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_field` (
  `field_id` int(5) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_field`
--

LOCK TABLES `et_field` WRITE;
/*!40000 ALTER TABLE `et_field` DISABLE KEYS */;
INSERT INTO `et_field` VALUES (2,'职称类','职称类',0),(3,'应知应会类','应知应会类',0),(4,'公司制度类','公司制度类',0);
/*!40000 ALTER TABLE `et_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_group`
--

DROP TABLE IF EXISTS `et_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(40) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_group_uid` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_group`
--

LOCK TABLES `et_group` WRITE;
/*!40000 ALTER TABLE `et_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_knowledge_point`
--

DROP TABLE IF EXISTS `et_knowledge_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_knowledge_point` (
  `point_id` int(5) NOT NULL AUTO_INCREMENT,
  `point_name` varchar(100) NOT NULL,
  `field_id` int(5) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) DEFAULT '1' COMMENT '1:正常 0：废弃',
  PRIMARY KEY (`point_id`),
  UNIQUE KEY `idx_point_name` (`point_name`) USING BTREE,
  KEY `fk_knowledge_field` (`field_id`),
  CONSTRAINT `et_knowledge_point_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `et_field` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_knowledge_point`
--

LOCK TABLES `et_knowledge_point` WRITE;
/*!40000 ALTER TABLE `et_knowledge_point` DISABLE KEYS */;
INSERT INTO `et_knowledge_point` VALUES (7,'人事制度',4,NULL,0);
/*!40000 ALTER TABLE `et_knowledge_point` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_menu_item`
--

DROP TABLE IF EXISTS `et_menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_menu_item` (
  `menu_id` varchar(50) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `menu_href` varchar(200) NOT NULL,
  `menu_seq` int(5) NOT NULL,
  `authority` varchar(20) NOT NULL,
  `parent_id` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_menu_item`
--

LOCK TABLES `et_menu_item` WRITE;
/*!40000 ALTER TABLE `et_menu_item` DISABLE KEYS */;
INSERT INTO `et_menu_item` VALUES ('question','试题管理','admin/question/question-list',1001,'ROLE_ADMIN','-1','fa-cloud',1),('question-list','试题管理','admin/question/question-list',100101,'ROLE_ADMIN','question','fa-list',1),('question-add','添加试题','admin/question/question-add',100102,'ROLE_ADMIN','question','fa-plus',1),('question-import','导入试题','admin/question/question-import',100103,'ROLE_ADMIN','question','fa-cloud-upload',1),('exampaper','试卷管理','admin/exampaper/exampaper-list/0',1002,'ROLE_ADMIN','-1','fa-file-text-o',1),('exampaper-list','试卷管理','admin/exampaper/exampaper-list/0',100201,'ROLE_ADMIN','exampaper','fa-list',1),('exampaper-add','创建新试卷','admin/exampaper/exampaper-add',100202,'ROLE_ADMIN','exampaper','fa-leaf',1),('exampaper-edit','修改试卷','',100203,'ROLE_ADMIN','exampaper','fa-pencil',0),('exampaper-preview','预览试卷','',100204,'ROLE_ADMIN','exampaper','fa-eye',0),('exam','考试管理','admin/exam/exam-list',1003,'ROLE_ADMIN','-1','fa-trophy',1),('exam-list','考试管理','admin/exam/exam-list',100301,'ROLE_ADMIN','exam','fa-list',1),('exam-add','发布考试','admin/exam/exam-add',100302,'ROLE_ADMIN','exam','fa-plus-square-o',1),('exam-student-list','学员名单','',100305,'ROLE_ADMIN','exam','fa-sitemap',0),('student-answer-sheet','学员试卷','',100306,'ROLE_ADMIN','exam','fa-file-o',0),('mark-exampaper','人工阅卷','',100307,'ROLE_ADMIN','exam','fa-circle-o-notch',0),('user','用户管理','admin/user/student-list',1005,'ROLE_ADMIN','-1','fa-user',1),('student-list','用户管理','admin/user/student-list',100501,'ROLE_ADMIN','user','fa-users',1),('student-examhistory','考试历史','',100502,'ROLE_ADMIN','user','fa-glass',0),('student-profile','学员资料','',100503,'ROLE_ADMIN','user','fa-flag-o',0),('teacher-list','教师管理','admin/user/teacher-list',100504,'ROLE_ADMIN','user','fa-cubes',1),('teacher-profile','教师资料','',100505,'ROLE_ADMIN','user',NULL,0),('training','培训','admin/training/training-list',1004,'ROLE_ADMIN','-1','fa-laptop',1),('training-list','培训管理','admin/training/training-list',100401,'ROLE_ADMIN','training','fa-list',1),('training-add','添加培训','admin/training/training-add',100402,'ROLE_ADMIN','training','fa-plus',1),('student-practice-status','学习进度','',100403,'ROLE_ADMIN','training','fa-rocket',0),('student-training-history','培训进度','',100404,'ROLE_ADMIN','training','fa-star-half-full',0),('common','通用数据','admin/common/tag-list',1006,'ROLE_ADMIN','-1','fa-cubes',1),('tag-list','标签管理','admin/common/tag-list',100601,'ROLE_ADMIN','common','fa-tags',1),('field-list','专业题库','admin/common/field-list',100602,'ROLE_ADMIN','common','fa-anchor',1),('knowledge-list','知识分类','admin/common/knowledge-list/0',100603,'ROLE_ADMIN','common','fa-flag',1),('question','试题管理','teacher/question/question-list',2001,'ROLE_TEACHER','-1','fa-cloud',1),('question-list','试题管理','teacher/question/question-list',200101,'ROLE_TEACHER','question','fa-list',1),('question-add','添加试题','teacher/question/question-add',200102,'ROLE_TEACHER','question','fa-plus',1),('question-import','导入试题','teacher/question/question-import',200103,'ROLE_TEACHER','question','fa-cloud-upload',1),('exampaper','试卷管理','teacher/exampaper/exampaper-list/0',2002,'ROLE_TEACHER','-1','fa-file-text-o',1),('exampaper-list','试卷管理','teacher/exampaper/exampaper-list/0',200201,'ROLE_TEACHER','exampaper','fa-list',1),('exampaper-add','创建新试卷','teacher/exampaper/exampaper-add',200202,'ROLE_TEACHER','exampaper','fa-leaf',1),('exampaper-edit','修改试卷','',200203,'ROLE_TEACHER','exampaper','fa-pencil',0),('exampaper-preview','预览试卷','',200204,'ROLE_TEACHER','exampaper','fa-eye',0),('exam','考试管理','teacher/exam/exam-list',2003,'ROLE_TEACHER','-1','fa-trophy',1),('exam-list','考试管理','teacher/exam/exam-list',200301,'ROLE_TEACHER','exam','fa-list',1),('exam-add','发布考试','teacher/exam/exam-add',200302,'ROLE_TEACHER','exam','fa-plus-square-o',1),('exam-student-list','学员名单','',200303,'ROLE_TEACHER','exam','fa-sitemap',0),('student-answer-sheet','学员试卷','',200304,'ROLE_TEACHER','exam','fa-file-o',0),('mark-exampaper','人工阅卷','',200305,'ROLE_TEACHER','exam','fa-circle-o-notch',0),('user','用户管理','teacher/user/student-list',2005,'ROLE_TEACHER','-1','fa-user',1),('student-list','用户管理','teacher/user/student-list',200501,'ROLE_TEACHER','user','fa-users',1),('student-examhistory','考试历史','',200502,'ROLE_TEACHER','user','fa-glass',0),('student-profile','学员资料','',200503,'ROLE_TEACHER','user','fa-flag-o',0),('training','培训','teacher/training/training-list',2004,'ROLE_TEACHER','-1','fa-laptop',1),('training-list','培训管理','teacher/training/training-list',200401,'ROLE_TEACHER','training','fa-list',1),('training-add','添加培训','teacher/training/training-add',200402,'ROLE_TEACHER','training','fa-plus',1),('student-practice-status','学习进度','',200403,'ROLE_TEACHER','training','fa-rocket',0),('student-training-history','培训进度','',200404,'ROLE_TEACHER','training','fa-star-half-full',0),('system','系统设置','admin/system/admin-list',1007,'ROLE_ADMIN','-1','fa-cog',1),('admin-list','管理员列表','admin/system/admin-list',100701,'ROLE_ADMIN','system','fa-group',1),('news-list','系统公告','admin/system/news-list',100703,'ROLE_ADMIN','system','fa-volume-up',1),('dep-list','部门管理','admin/common/dep-list',100604,'ROLE_ADMIN','common','fa-leaf',1),('model-test-add','发布模拟考试','admin/exam/model-test-add',100304,'ROLE_ADMIN','exam','fa-flag',1),('model-test-list','模拟考试','admin/exam/model-test-list',100303,'ROLE_ADMIN','exam','fa-glass',1),('dashboard','控制面板','admin/dashboard',1000,'ROLE_ADMIN','-1','fa-dashboard',1),('','','',0,'ROLE_ADMIN','',NULL,1);
/*!40000 ALTER TABLE `et_menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_news`
--

DROP TABLE IF EXISTS `et_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`news_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `et_news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_news`
--

LOCK TABLES `et_news` WRITE;
/*!40000 ALTER TABLE `et_news` DISABLE KEYS */;
INSERT INTO `et_news` VALUES (1,'在线考试系统正式发布','在线考试系统正式发布',1,'2015-10-27 17:46:37'),(2,'这是一条测试信息','这是一条测试这是一条测试这是一条测试这是一条测试这是一条测试这是一条测试这是一条测试这是一条测试这是一条测试这是一条测试',1,'2016-06-02 06:24:58'),(3,'dsfdsafdsfdsa','fdsfsdfsdfdsaf',1,'2016-06-02 07:23:32');
/*!40000 ALTER TABLE `et_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_practice_paper`
--

DROP TABLE IF EXISTS `et_practice_paper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_practice_paper` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_practice_paper`
--

LOCK TABLES `et_practice_paper` WRITE;
/*!40000 ALTER TABLE `et_practice_paper` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_practice_paper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_question`
--

DROP TABLE IF EXISTS `et_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `question_type_id` int(11) NOT NULL COMMENT '题型',
  `duration` int(11) DEFAULT NULL COMMENT '试题考试时间',
  `points` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试题可见性',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(20) NOT NULL DEFAULT 'admin' COMMENT '创建者',
  `last_modify` timestamp NULL DEFAULT NULL,
  `answer` mediumtext NOT NULL,
  `expose_times` int(11) NOT NULL DEFAULT '2',
  `right_times` int(11) NOT NULL DEFAULT '1',
  `wrong_times` int(11) NOT NULL DEFAULT '1',
  `difficulty` int(5) NOT NULL DEFAULT '1',
  `analysis` mediumtext,
  `reference` varchar(1000) DEFAULT NULL,
  `examing_point` varchar(5000) DEFAULT NULL,
  `keyword` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_type_id` (`question_type_id`),
  KEY `et_question_ibfk_5` (`creator`),
  CONSTRAINT `et_question_ibfk_1` FOREIGN KEY (`question_type_id`) REFERENCES `et_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_question`
--

LOCK TABLES `et_question` WRITE;
/*!40000 ALTER TABLE `et_question` DISABLE KEYS */;
INSERT INTO `et_question` VALUES (53,'测试试题内容，这是试','{\"title\":\"测试试题内容，这是试题正文部分哦，题目答案是A\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"答案1\",\"B\":\"答案2\",\"C\":\"答案3\",\"D\":\"答案4\"},\"choiceImgList\":{}}',1,NULL,0,NULL,0,'2016-06-02 08:30:05','admin',NULL,'A',2,1,1,1,'这道题是用来测试的额','','测试考点','');
/*!40000 ALTER TABLE `et_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_question_2_point`
--

DROP TABLE IF EXISTS `et_question_2_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_question_2_point` (
  `question_2_point_id` int(10) NOT NULL AUTO_INCREMENT,
  `question_id` int(10) DEFAULT NULL,
  `point_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`question_2_point_id`),
  KEY `fk_question_111` (`question_id`),
  KEY `fk_point_111` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_1` FOREIGN KEY (`point_id`) REFERENCES `et_knowledge_point` (`point_id`) ON DELETE CASCADE,
  CONSTRAINT `et_question_2_point_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_question_2_point`
--

LOCK TABLES `et_question_2_point` WRITE;
/*!40000 ALTER TABLE `et_question_2_point` DISABLE KEYS */;
INSERT INTO `et_question_2_point` VALUES (50,53,7);
/*!40000 ALTER TABLE `et_question_2_point` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_question_2_tag`
--

DROP TABLE IF EXISTS `et_question_2_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_question_2_tag` (
  `question_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`question_tag_id`),
  KEY `fk_question_tag_tid` (`tag_id`),
  KEY `fk_question_tag_qid` (`question_id`),
  CONSTRAINT `et_question_2_tag_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `et_question_2_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `et_tag` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_question_2_tag`
--

LOCK TABLES `et_question_2_tag` WRITE;
/*!40000 ALTER TABLE `et_question_2_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_question_2_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_question_type`
--

DROP TABLE IF EXISTS `et_question_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_question_type` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `subjective` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_question_type`
--

LOCK TABLES `et_question_type` WRITE;
/*!40000 ALTER TABLE `et_question_type` DISABLE KEYS */;
INSERT INTO `et_question_type` VALUES (1,'单选题',0),(2,'多选题',0),(3,'判断题',0),(4,'填空题',0),(5,'简答题',1),(6,'论述题',1),(7,'分析题',1);
/*!40000 ALTER TABLE `et_question_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_reference`
--

DROP TABLE IF EXISTS `et_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_reference` (
  `reference_id` int(5) NOT NULL,
  `reference_name` varchar(200) NOT NULL,
  `memo` varchar(200) DEFAULT NULL,
  `state` decimal(10,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_reference`
--

LOCK TABLES `et_reference` WRITE;
/*!40000 ALTER TABLE `et_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_role`
--

DROP TABLE IF EXISTS `et_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_role` (
  `id` int(11) NOT NULL,
  `authority` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_role`
--

LOCK TABLES `et_role` WRITE;
/*!40000 ALTER TABLE `et_role` DISABLE KEYS */;
INSERT INTO `et_role` VALUES (1,'ROLE_ADMIN','超级管理员','admin'),(2,'ROLE_TEACHER','教师','teacher'),(3,'ROLE_STUDENT','学员','student');
/*!40000 ALTER TABLE `et_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_tag`
--

DROP TABLE IF EXISTS `et_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(100) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` int(11) NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `memo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `fk_tag_creator` (`creator`),
  CONSTRAINT `et_tag_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_tag`
--

LOCK TABLES `et_tag` WRITE;
/*!40000 ALTER TABLE `et_tag` DISABLE KEYS */;
INSERT INTO `et_tag` VALUES (3,'易错题','2015-08-07 12:42:00',1,0,'易错题'),(4,'简单','2015-08-16 09:46:42',1,0,'简单'),(6,'送分题','2015-08-16 14:23:59',1,0,'送分题');
/*!40000 ALTER TABLE `et_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_training`
--

DROP TABLE IF EXISTS `et_training`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_training` (
  `training_id` int(11) NOT NULL AUTO_INCREMENT,
  `training_name` varchar(40) NOT NULL,
  `training_desc` mediumtext,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未发布；1：发布；2：失效',
  `state_time` timestamp NULL DEFAULT NULL,
  `exp_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`training_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_training`
--

LOCK TABLES `et_training` WRITE;
/*!40000 ALTER TABLE `et_training` DISABLE KEYS */;
INSERT INTO `et_training` VALUES (1,'测试视频培训','test',0,1,'2016-06-02 06:34:29',1,0,NULL,NULL);
/*!40000 ALTER TABLE `et_training` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_training_section`
--

DROP TABLE IF EXISTS `et_training_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_training_section` (
  `section_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '1',
  `section_name` varchar(200) NOT NULL,
  `section_desc` mediumtext,
  `training_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `file_name` varchar(200) DEFAULT NULL,
  `file_path` varchar(200) DEFAULT NULL,
  `file_md5` varchar(200) DEFAULT NULL,
  `file_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_training_section`
--

LOCK TABLES `et_training_section` WRITE;
/*!40000 ALTER TABLE `et_training_section` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_training_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user`
--

DROP TABLE IF EXISTS `et_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `user_name` varchar(50) NOT NULL COMMENT '账号',
  `true_name` varchar(50) NOT NULL COMMENT '真实姓名',
  `national_id` varchar(20) NOT NULL,
  `password` char(80) NOT NULL,
  `email` varchar(60) NOT NULL,
  `phone_num` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态：0-未激活 1-激活',
  `field_id` int(10) NOT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `login_time` timestamp NULL DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL COMMENT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_user_uid` (`user_name`),
  KEY `idx_user_national_id` (`national_id`),
  KEY `idx_user_email` (`email`),
  KEY `idx_user_phone` (`phone_num`)
) ENGINE=InnoDB AUTO_INCREMENT=4715 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user`
--

LOCK TABLES `et_user` WRITE;
/*!40000 ALTER TABLE `et_user` DISABLE KEYS */;
INSERT INTO `et_user` VALUES (1,'admin','admin','000000000000000000','260acbffd3c30786febc29d7dd71a9880a811e77','1111@111.com','18595115000','2016-06-02 06:23:58',0,1,1,'2015-08-06 03:31:34','2015-08-06 03:31:50','',''),(2,'student','学员','420000000000000000','3f70af5072e23c9bf59dd1ac1c91f9f8fcc81478','133@189.cn','13333333333','2015-12-11 13:32:07',1,1,0,'2015-08-06 03:31:34','2015-08-06 03:31:34','',''),(4714,'student2','studen','642223198812040021','9a70e2e0cee29280fcbff1f9b2b2f99bfd1d10ed','2131@12.com','13990511123','2016-06-02 07:18:47',-1,1,0,NULL,NULL,NULL,'');
/*!40000 ALTER TABLE `et_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user_2_department`
--

DROP TABLE IF EXISTS `et_user_2_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user_2_department` (
  `user_id` int(11) NOT NULL,
  `dep_id` int(11) NOT NULL,
  KEY `fk_ud_uid` (`user_id`),
  KEY `fk_ud_did` (`dep_id`),
  CONSTRAINT `fk_ud_did` FOREIGN KEY (`dep_id`) REFERENCES `et_department` (`dep_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ud_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user_2_department`
--

LOCK TABLES `et_user_2_department` WRITE;
/*!40000 ALTER TABLE `et_user_2_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_user_2_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user_2_group`
--

DROP TABLE IF EXISTS `et_user_2_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user_2_group` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_admin` tinyint(4) DEFAULT '0',
  UNIQUE KEY `idx_user_guid` (`group_id`,`user_id`) USING BTREE,
  KEY `idx_user_gid` (`group_id`),
  KEY `idx_user_uid` (`user_id`),
  CONSTRAINT `fk_et_user_group_et_group_1` FOREIGN KEY (`group_id`) REFERENCES `et_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_et_user_group_et_user_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user_2_group`
--

LOCK TABLES `et_user_2_group` WRITE;
/*!40000 ALTER TABLE `et_user_2_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_user_2_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user_2_role`
--

DROP TABLE IF EXISTS `et_user_2_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user_2_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `et_r_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`),
  CONSTRAINT `fk_user_rid` FOREIGN KEY (`role_id`) REFERENCES `et_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user_2_role`
--

LOCK TABLES `et_user_2_role` WRITE;
/*!40000 ALTER TABLE `et_user_2_role` DISABLE KEYS */;
INSERT INTO `et_user_2_role` VALUES (1,1),(2,3),(4714,3);
/*!40000 ALTER TABLE `et_user_2_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user_exam_history`
--

DROP TABLE IF EXISTS `et_user_exam_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user_exam_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) NOT NULL,
  `exam_paper_id` int(10) NOT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `point` int(5) DEFAULT '0',
  `seri_no` varchar(100) NOT NULL,
  `content` mediumtext,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `answer_sheet` mediumtext,
  `duration` int(10) NOT NULL,
  `point_get` float(10,1) NOT NULL DEFAULT '0.0',
  `submit_time` timestamp NULL DEFAULT NULL,
  `approved` tinyint(4) DEFAULT '0',
  `verify_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_exam_his_seri_no` (`seri_no`),
  UNIQUE KEY `idx_exam_pid` (`exam_id`,`exam_paper_id`,`user_id`) USING BTREE,
  KEY `fk_exam_his_uid` (`user_id`),
  KEY `fk_exam_paper_id` (`exam_paper_id`),
  CONSTRAINT `fk_exam_his_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`),
  CONSTRAINT `fk_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `et_exam` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exam_paper_id` FOREIGN KEY (`exam_paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user_exam_history`
--

LOCK TABLES `et_user_exam_history` WRITE;
/*!40000 ALTER TABLE `et_user_exam_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_user_exam_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user_question_history`
--

DROP TABLE IF EXISTS `et_user_question_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user_question_history` (
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_type_id` int(11) NOT NULL,
  `is_right` tinyint(4) NOT NULL DEFAULT '1',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `idx_hist_uqid` (`question_id`,`user_id`) USING BTREE,
  KEY `fk_hist_uid` (`user_id`),
  KEY `fk_hist_qid` (`question_id`),
  CONSTRAINT `fk_hist_qid` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hist_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user_question_history`
--

LOCK TABLES `et_user_question_history` WRITE;
/*!40000 ALTER TABLE `et_user_question_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_user_question_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_user_training_history`
--

DROP TABLE IF EXISTS `et_user_training_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_user_training_history` (
  `training_id` int(11) NOT NULL COMMENT '培训ID',
  `section_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `duration` float(11,4) NOT NULL DEFAULT '0.0000',
  `process` float(11,2) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_state_time` timestamp NULL DEFAULT NULL,
  `user_training_detail` mediumtext,
  PRIMARY KEY (`section_id`,`user_id`),
  UNIQUE KEY `et_r_user_training_history_uk_1` (`user_id`,`section_id`) USING BTREE,
  CONSTRAINT `fk_user_training_history_sid` FOREIGN KEY (`section_id`) REFERENCES `et_training_section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_training_history_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户培训历史记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_user_training_history`
--

LOCK TABLES `et_user_training_history` WRITE;
/*!40000 ALTER TABLE `et_user_training_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `et_user_training_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `et_view_type`
--

DROP TABLE IF EXISTS `et_view_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `et_view_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='培训视图表现形式';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `et_view_type`
--

LOCK TABLES `et_view_type` WRITE;
/*!40000 ALTER TABLE `et_view_type` DISABLE KEYS */;
INSERT INTO `et_view_type` VALUES (1,'PDF'),(2,'PPT'),(3,'WORD'),(4,'TXT'),(5,'SWF'),(6,'EXCEL'),(7,'MP4'),(8,'FLV');
/*!40000 ALTER TABLE `et_view_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_c3p0`
--

DROP TABLE IF EXISTS `t_c3p0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_c3p0` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_c3p0`
--

LOCK TABLES `t_c3p0` WRITE;
/*!40000 ALTER TABLE `t_c3p0` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_c3p0` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-02 16:31:56
