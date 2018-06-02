-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 39.108.143.172    Database: sys
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Table structure for table `Document`
--

DROP TABLE IF EXISTS `Document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Document` (
  `id` bigint(15) NOT NULL COMMENT '唯一标识',
  `userId` bigint(15) NOT NULL COMMENT '用户id\n应该用adminId，只有当登录账户是管理员时才能操作文档。\n需要先建Admin表，新增登录等相关接口。',
  `version` tinyint(4) NOT NULL DEFAULT '2' COMMENT '接口版本号\n<=0 - 不限制版本，任意版本都可用这个接口\n>0 - 在这个版本添加的接口',
  `name` varchar(100) NOT NULL COMMENT '接口名称',
  `url` varchar(250) NOT NULL COMMENT '请求地址',
  `request` text NOT NULL COMMENT '请求\n用json格式会导致强制排序，而请求中引用赋值只能引用上面的字段，必须有序。',
  `response` text COMMENT '标准返回结果JSON\n用json格式会导致强制排序，而请求中引用赋值只能引用上面的字段，必须有序。',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='测试用例文档\n后端开发者在测试好后，把选好的测试用例上传，这样就能共享给前端/客户端开发者';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Document`
--

LOCK TABLES `Document` WRITE;
/*!40000 ALTER TABLE `Document` DISABLE KEYS */;
INSERT INTO `Document` VALUES (1,0,1,'登录','/login','{\"type\": 0, \"phone\": \"13000082001\", \"version\": 1, \"password\": \"123456\"}',NULL,'2017-11-26 07:35:19'),(2,0,1,'注册(先获取验证码type:1)','/register','{\n    \"Privacy\": {\n        \"phone\": \"13000083333\",\n        \"_password\": \"123456\"\n    },\n    \"User\": {\n        \"name\": \"APIJSONUser\"\n    },\n    \"verify\": \"6840\"\n}',NULL,NULL),(3,0,1,'退出登录','/logout','{}',NULL,'2017-11-26 09:56:10'),(1511689914599,0,1,'获取用户隐私信息','/gets','{\"tag\": \"Privacy\", \"Privacy\": {\"id\": 82001}}',NULL,'2017-11-26 09:51:54'),(1511796155277,0,1,'获取验证码','/post/verify','{\"type\": 0, \"phone\": \"13000082001\"}',NULL,'2017-11-27 15:22:35'),(1511796208670,0,1,'检查验证码是否存在','/heads/verify','{\"type\": 0, \"phone\": \"13000082001\"}',NULL,'2017-11-27 15:23:28'),(1511796589079,0,1,'修改登录密码(先获取验证码type:2)-手机号+验证码','/put/password','{\"verify\": \"10322\", \"Privacy\": {\"phone\": \"13000082001\", \"_password\": \"666666\"}}',NULL,'2017-11-27 15:29:49'),(1511796882184,0,1,'充值(需要支付密码)/提现','/put/balance','{\"tag\": \"Privacy\", \"Privacy\": {\"id\": 82001, \"balance+\": 100.15, \"_payPassword\": \"123456\"}}',NULL,'2017-11-27 15:34:42'),(1511963330795,0,2,'获取文档列表(即在线解析网页上的共享)-API调用方式','/get','{\n    \"Document[]\": {\n        \"Document\": {\n            \"@role\": \"login\",\n            \"@order\": \"version-,date-\"\n        }\n    }\n}',NULL,'2017-11-29 13:48:50'),(1511963677325,0,1,'获取用户','/get','{\"User\": {\"id\": 82001}}',NULL,'2017-11-29 13:54:37'),(1511963722970,0,1,'获取用户列表(\"id{}\":contactIdList)-朋友页','/get','{\n    \"User[]\": {\n        \"count\": 10,\n        \"page\": 0,\n        \"User\": {\n            \"@column\": \"id,sex,name,tag,head\",\n            \"@order\": \"name+\",\n            \"id{}\": [\n                82002,\n                82004,\n                70793\n            ]\n        }\n    }\n}',NULL,'2017-11-29 13:55:22'),(1511963990072,0,1,'获取动态Moment+User+praiseUserList','/get','{\n    \"Moment\": {\n        \"id\": 15\n    },\n    \"User\": {\n        \"id@\": \"Moment/userId\",\n        \"@column\": \"id,name,head\"\n    },\n    \"User[]\": {\n        \"count\": 10,\n        \"User\": {\n            \"id{}@\": \"Moment/praiseUserIdList\",\n            \"@column\": \"id,name\"\n        }\n    }\n}',NULL,'2017-11-29 13:59:50'),(1511964176689,0,1,'获取评论列表-动态详情页Comment+User','/get','{\n    \"[]\": {\n        \"count\": 20,\n        \"page\": 0,\n        \"Comment\": {\n            \"@order\": \"date+\",\n            \"momentId\": 15\n        },\n        \"User\": {\n            \"id@\": \"/Comment/userId\",\n            \"@column\": \"id,name,head\"\n        }\n    }\n}',NULL,'2017-11-29 14:02:56'),(1511967853340,0,1,'获取动态列表Moment+User+User:parise[]+Comment[]','/get','{\n    \"[]\": {\n        \"count\": 5,\n        \"page\": 0,\n        \"Moment\": {\n            \"@order\": \"date-\"\n        },\n        \"User\": {\n            \"id@\": \"/Moment/userId\",\n            \"@column\": \"id,name,head\"\n        },\n        \"User[]\": {\n            \"count\": 10,\n            \"User\": {\n                \"id{}@\": \"[]/Moment/praiseUserIdList\",\n                \"@column\": \"id,name\"\n            }\n        },\n        \"[]\": {\n            \"count\": 6,\n            \"Comment\": {\n                \"@order\": \"date+\",\n                \"momentId@\": \"[]/Moment/id\"\n            },\n            \"User\": {\n                \"id@\": \"/Comment/userId\",\n                \"@column\": \"id,name\"\n            }\n        }\n    }\n}',NULL,'2017-11-29 15:04:13'),(1511969181104,0,1,'添加朋友','/put','{\n    \"User\": {\n        \"id\": 82001,\n        \"contactIdList+\": [93793]\n    },\n    \"tag\": \"User\"\n}',NULL,'2017-11-29 15:26:21'),(1511969417633,0,1,'点赞/取消点赞','/put','{\n    \"Moment\": {\n        \"id\": 15,\n        \"praiseUserIdList-\": [\n            82001\n        ]\n    },\n    \"tag\": \"Moment\"\n}',NULL,'2017-11-29 15:30:17'),(1511969630372,0,1,'新增评论','/post','{\n    \"Comment\": {\n        \"userId\": 82001,\n        \"momentId\": 15,\n        \"content\": \"测试新增评论\"\n    },\n    \"tag\": \"Comment\"\n}',NULL,'2017-11-29 15:33:50'),(1511970009072,0,1,'新增动态','/post','{\n    \"Moment\": {\n        \"userId\": 82001,\n        \"content\": \"测试新增动态\",\n        \"pictureList\": [\"http://static.oschina.net/uploads/user/48/96331_50.jpg\"\n        ]\n    },\n    \"tag\": \"Moment\"\n}',NULL,'2017-11-29 15:40:09'),(1511970224333,0,1,'修改用户信息','/put','{\n    \"User\": {\n        \"id\": 82001,\n        \"name\": \"测试改名\"\n    },\n    \"tag\": \"User\"\n}',NULL,'2017-11-29 15:43:44'),(1512216131855,0,1,'获取文档列表(即在线解析网页上的文档)-表和字段、请求格式限制','/get','{\n    \"[]\": {\n        \"Table\": {\n            \"TABLE_SCHEMA\": \"sys\",\n            \"TABLE_TYPE\": \"BASE TABLE\",\n            \"TABLE_NAME!$\": [\n                \"\\\\_%\",\n                \"sys\\\\_%\",\n                \"system\\\\_%\"\n            ],\n            \"@order\": \"TABLE_NAME+\",\n            \"@column\": \"TABLE_NAME,TABLE_COMMENT\"\n        },\n        \"Column[]\": {\n            \"Column\": {\n                \"TABLE_NAME@\": \"[]/Table/TABLE_NAME\",\n                \"@column\": \"COLUMN_NAME,COLUMN_TYPE,IS_NULLABLE,COLUMN_COMMENT\"\n            }\n        }\n    },\n    \"Request[]\": {\n        \"Request\": {\n            \"@order\": \"version-,method-\"\n        }\n    }\n}',NULL,'2017-12-02 12:02:11'),(1521901518765,0,2,'功能符(对象关键词): ⑤从pictureList获取第0张图片：','/get','{\"User\":{\"id\":38710,\"@position\":0,\"firstPicture()\":\"get(Collection:pictureList,int:@position)\"}}',NULL,'2018-03-24 14:25:18'),(1521901610784,0,2,'功能符(对象关键词): ④查询 按userId分组、id最大值>=100 的Moment数组','/get','{\"[]\":{\"count\":10,\"Moment\":{\"@column\":\"userId,max(id):maxId\",\"@group\":\"userId\",\"@having\":\"maxId>=100\"}}}',NULL,'2018-03-24 14:26:50'),(1521901682846,0,2,'功能符(对象关键词): ③查询按userId分组的Moment数组','/get','{\"[]\":{\"count\":10,\"Moment\":{\"@column\":\"userId,id\",\"@group\":\"userId,id\"}}}',NULL,'2018-03-24 14:28:02'),(1521901746809,0,2,'功能符(对象关键词): ②查询按 name降序、id默认顺序 排序的User数组','/get','{\"[]\":{\"count\":10,\"User\":{\"@column\":\"name,id\",\"@order\":\"name-,id\"}}}',NULL,'2018-03-24 14:29:06'),(1521901787203,0,2,'功能符(对象关键词): ①只查询id,sex,name这几列并且请求结果也按照这个顺序','/get','{\"User\":{\"@column\":\"id,sex,name\",\"id\":38710}}',NULL,'2018-03-24 14:29:47'),(1521902033332,0,2,'功能符(数组关键词): ③查询User数组和对应的User总数','/get','{\"[]\":{\"query\":2,\"count\":5,\"User\":{}},\"total@\":\"/[]/total\"}',NULL,'2018-03-24 14:33:53'),(1521902069871,0,2,'功能符(数组关键词): ②查询第3页的User数组，每页5个','/get','{\"[]\":{\"count\":5,\"page\":3,\"User\":{}}}',NULL,'2018-03-24 14:34:29'),(1521902110680,0,2,'功能符(数组关键词): ①查询User数组，最多5个','/get','{\"[]\":{\"count\":5,\"User\":{}}}',NULL,'2018-03-24 14:35:10'),(1521903761689,0,2,'功能符(逻辑运算): ③ ! 非运算','/head','{\"User\":{\"id!{}\":[82001,38710]}}',NULL,'2018-03-24 15:02:41'),(1521903828410,0,2,'功能符(逻辑运算): ② | 或运算','/head','{\"User\":{\"id|{}\":\">90000,<=80000\"}}',NULL,'2018-03-24 15:03:48'),(1521903882830,0,2,'功能符(逻辑运算): ① & 与运算','/head','{\"User\":{\"id&{}\":\">80000,<=90000\"}}',NULL,'2018-03-24 15:04:42'),(1521904098111,0,2,'功能符: 减少 或 去除','/put/balance','{\n    \n    \"Privacy\": {\n        \"id\": 82001,\n        \"balance+\": -100,\n        \"_payPassword\": \"123456\"\n    },\"tag\": \"Privacy\"\n}',NULL,'2018-03-24 15:08:18'),(1521904162066,0,2,'功能符: 增加 或 扩展','/put','{\n    \"Moment\": {\n        \"id\": 15,\n        \"praiseUserIdList+\": [\n            82001\n        ]\n    },\n    \"tag\": \"Moment\"\n}',NULL,'2018-03-24 15:09:22'),(1521904337054,0,2,'功能符: 新建别名','/get','{\"Comment\":{\"@column\":\"id,toId:parentId\",\"id\":51}}',NULL,'2018-03-24 15:12:17'),(1521904394042,0,2,'功能符: 正则匹配','/get','{\"User[]\":{\"count\":3,\"User\":{\"name?\":\"^[0-9]+$\"}}}',NULL,'2018-03-24 15:13:14'),(1521904437584,0,2,'功能符: 模糊搜索','/get','{\"User[]\":{\"count\":3,\"User\":{\"name$\":\"%m%\"}}}',NULL,'2018-03-24 15:13:57'),(1521904547992,0,2,'功能符: 引用赋值','/get','{\"Moment\":{\n   \"userId\":38710\n},\n\"User\":{\n   \"id@\":\"/Moment/userId\"\n}}',NULL,'2018-03-24 15:15:47'),(1521904617127,0,2,'功能符: 远程调用函数','/get','{\"Moment\":{\"id\":301,\"isPraised()\":\"isContain(Collection:praiseUserIdList,userId)\"}}',NULL,'2018-03-24 15:16:57'),(1521904653622,0,2,'功能符: 包含选项范围','/get','{\"User[]\":{\"count\":3,\"User\":{\"contactIdList<>\":38710}}}',NULL,'2018-03-24 15:17:33'),(1521904698935,0,2,'功能符: 匹配条件范围','/get','{\"User[]\":{\"count\":3,\"User\":{\"id{}\":\"<=80000,>90000\"}}}',NULL,'2018-03-24 15:18:18'),(1521904756674,0,2,'功能符: 查询数组','/get','{\"User[]\":{\"count\":3,\"User\":{}}}',NULL,'2018-03-24 15:19:16'),(1521905263828,0,2,'操作方法(DELETE):  删除数据','/delete','{\n   \"Moment\":{\n     \"id\":120\n   },\n   \"tag\":\"Moment\"\n}',NULL,'2018-03-24 15:27:43'),(1521905599150,0,2,'操作方法(PUT):  修改数据，只修改所传的字段','/put','{\n   \"Moment\":{\n     \"id\":235,\n     \"content\":\"APIJSON,let interfaces and documents go to hell !\"\n   },\n   \"tag\":\"Moment\"\n}',NULL,'2018-03-24 15:33:19'),(1521905680680,0,2,'操作方法(POST):  新增数据','/post','{\n    \"Moment\": {\n        \"userId\": 38710,\n        \"content\": \"APIJSON,let interfaces and documents go to hell !\"\n    },\n    \"tag\": \"Moment\"\n}',NULL,'2018-03-24 15:34:40'),(1521905787850,0,2,'操作方法(HEADS):  安全/私密获取数量，用于获取银行卡数量等 对安全性要求高的数据总数','/heads','{\n    \"Login\": {\n        \"userId\": 38710,\"type\":1\n    },\n    \"tag\": \"Login\"\n}',NULL,'2018-03-24 15:36:27'),(1521905868719,0,2,'操作方法(GETS):  安全/私密获取数据，用于获取钱包等 对安全性要求高的数据','/gets','{\n    \"Privacy\": {\n        \"id\": 82001\n    },\n    \"tag\": \"Privacy\"\n}',NULL,'2018-03-24 15:37:48'),(1521905895591,0,2,'操作方法(HEAD):  普通获取数量，可用浏览器调试','/head','{\n   \"Moment\":{\n     \"userId\":38710\n   }\n}',NULL,'2018-03-24 15:38:15'),(1521905913188,0,2,'操作方法(GET):  普通获取数据，可用浏览器调试','/get','{\n   \"Moment\":{\n     \"id\":235\n   }\n}',NULL,'2018-03-24 15:38:33'),(1521906240332,0,2,'User发布的Moment列表，每个Moment包括 1.发布者User 2.前3条Comment: ③不查已获取的User','/get','{\n   \"[]\":{\n     \"page\":0,\n     \"count\":3, \n     \"Moment\":{\n       \"userId\":38710\n     },\n     \"Comment[]\":{\n       \"count\":3,\n       \"Comment\":{\n         \"momentId@\":\"[]/Moment/id\"\n       }\n     }\n   }\n}',NULL,'2018-03-24 15:44:00'),(1521906265960,0,2,'User发布的Moment列表，每个Moment包括 1.发布者User 2.前3条Comment: ②省去重复的User','/get','{\n   \"User\":{\n     \"id\":38710\n   },\n   \"[]\":{\n     \"page\":0,\n     \"count\":3, \n     \"Moment\":{\n       \"userId\":38710\n     }, \n     \"Comment[]\":{\n       \"count\":3,\n       \"Comment\":{\n         \"momentId@\":\"[]/Moment/id\"\n       }\n     }\n   }\n}',NULL,'2018-03-24 15:44:25'),(1521906517001,0,2,'User发布的Moment列表，每个Moment包括 1.发布者User 2.前3条Comment: ①指定id','/get','{\n    \"[]\": {\n        \"page\": 0,\n        \"count\": 3,\n        \"Moment\":{\"userId\":38710}, \"User\":{\"id\":38710} ,\n        \"Comment[]\": {\n            \"count\": 3,\n            \"Comment\": {\n                \"momentId@\": \"[]/Moment/id\"\n            }\n        }\n    }\n}',NULL,'2018-03-24 15:48:37'),(1521907009308,0,2,'Moment列表，每个Moment包括 1.发布者User 2.前3条Comment','/get','{\n   \"[]\":{\n     \"page\":0, \n     \"count\":3, \n     \"Moment\":{}, \n     \"User\":{\n       \"id@\":\"/Moment/userId\"\n     },\n     \"Comment[]\":{\n       \"count\":3,\n       \"Comment\":{\n         \"momentId@\":\"[]/Moment/id\"\n       }\n     }\n   }\n}',NULL,'2018-03-24 15:56:49'),(1521907303540,0,2,'User列表','/get','{\n   \"User[]\":{\n     \"page\":0,\n     \"count\":3, \n     \"User\":{\n       \"sex\":0\n     }\n   }\n}',NULL,'2018-03-24 16:01:43'),(1521907317871,0,2,'Moment和对应的User','/get','{\n   \"Moment\":{\n     \"userId\":38710\n   }, \n   \"User\":{\n     \"id\":38710\n   }\n}',NULL,'2018-03-24 16:01:57'),(1521907333045,0,2,'User','/get','{\n   \"User\":{\n     \"id\":38710\n   }\n}',NULL,'2018-03-24 16:02:13'),(1521907546129,0,2,'获取类似微信朋友圈的动态列表','/get','{\n    \"[]\": {\n        \"page\": 0,\n        \"count\": 2,\n        \"Moment\": {\n            \"content$\": \"%a%\"\n        },\n        \"User\": {\n            \"id@\": \"/Moment/userId\",\n            \"@column\": \"id,name,head\"\n        },\n        \"Comment[]\": {\n            \"count\": 2,\n            \"Comment\": {\n                \"momentId@\": \"[]/Moment/id\"\n            }\n        }\n    }\n}',NULL,'2018-03-24 16:05:46'),(1521907570452,0,2,'获取动态及发布者用户','/get','{\n    \"Moment\": {},\n    \"User\": {\n        \"id@\": \"Moment/userId\"\n    }\n}',NULL,'2018-03-24 16:06:10'),(1521907587430,0,2,'获取用户列表','/get','{\n    \"[]\": {\n        \"count\": 3,\n        \"User\": {\n            \"@column\": \"id,name\"\n        }\n    }\n}',NULL,'2018-03-24 16:06:27'),(1521907601299,0,2,'获取用户','/get','{\n  \"User\":{\n  }\n}',NULL,'2018-03-24 16:06:41'),(1523158852309,82001,2,'gets请求','/gets','{\n    \"Privacy\": {\n        \"id\": 82001\n    },\n    \"tag\": \"Privacy\"\n}',NULL,'2018-04-08 03:40:52'),(1523158885062,82001,2,'get请求','/get','{\n    \"[]\": {\n        \"count\": 3,\n        \"User\": {\n            \"@column\": \"id,name\"\n        }\n    }\n}',NULL,'2018-04-08 03:41:25'),(1524738544299,82001,2,'head请求','/head','{\n   \"Moment\":{\n     \"userId\":38710\n   }\n}',NULL,'2018-04-26 10:29:04'),(1524738565240,82001,2,'get请求','/get','{\n   \"User\":{\n     \"id\":38710\n   }\n}',NULL,'2018-04-26 10:29:25'),(1527584635426,82001,2,'q','/gets','{\n    \"Privacy\": {\n        \"id\": 82001\n    },\n    \"tag\": \"Privacy\"\n}',NULL,'2018-05-29 09:03:55');
/*!40000 ALTER TABLE `Document` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-03  0:13:12
