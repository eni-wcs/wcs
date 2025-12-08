/*
MySQL Backup
Database: inventory
Backup Time: 2023-06-09 14:59:03
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `inventory`.`auth_group`;
DROP TABLE IF EXISTS `inventory`.`auth_group_permissions`;
DROP TABLE IF EXISTS `inventory`.`auth_permission`;
DROP TABLE IF EXISTS `inventory`.`auth_user`;
DROP TABLE IF EXISTS `inventory`.`auth_user_groups`;
DROP TABLE IF EXISTS `inventory`.`auth_user_user_permissions`;
DROP TABLE IF EXISTS `inventory`.`django_admin_log`;
DROP TABLE IF EXISTS `inventory`.`django_content_type`;
DROP TABLE IF EXISTS `inventory`.`django_migrations`;
DROP TABLE IF EXISTS `inventory`.`django_session`;
DROP TABLE IF EXISTS `inventory`.`init_backup_form`;
DROP TABLE IF EXISTS `inventory`.`init_check_sheet`;
DROP TABLE IF EXISTS `inventory`.`init_in_storage`;
DROP TABLE IF EXISTS `inventory`.`init_material`;
DROP TABLE IF EXISTS `inventory`.`init_month`;
DROP TABLE IF EXISTS `inventory`.`init_out_storage`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1886 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `init_backup_form` (
  `B_number` int NOT NULL AUTO_INCREMENT,
  `B_administrator` varchar(20) NOT NULL,
  `B_date` datetime(6) NOT NULL,
  `B_file` varchar(100) NOT NULL,
  PRIMARY KEY (`B_number`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `init_check_sheet` (
  `Cnumber` int NOT NULL AUTO_INCREMENT,
  `C_date` datetime(6) NOT NULL,
  `Now_inventory` int NOT NULL,
  `Actual_num` int NOT NULL,
  `Mnumber_id` varchar(10) NOT NULL,
  PRIMARY KEY (`Cnumber`),
  KEY `init_check_sheet_Mnumber_id_12d9a97b_fk_init_material_Mnumber` (`Mnumber_id`),
  CONSTRAINT `init_check_sheet_Mnumber_id_12d9a97b_fk_init_material_Mnumber` FOREIGN KEY (`Mnumber_id`) REFERENCES `init_material` (`Mnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `init_in_storage` (
  `In_number` int NOT NULL AUTO_INCREMENT,
  `Source` varchar(8) NOT NULL,
  `In_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `In_supplier` varchar(20) NOT NULL,
  `In_inventory` int NOT NULL,
  `Mnumber_id` varchar(10) NOT NULL,
  PRIMARY KEY (`In_number`),
  KEY `init_in_storage_Mnumber_id_b3b8c736_fk_init_material_Mnumber` (`Mnumber_id`),
  CONSTRAINT `init_in_storage_Mnumber_id_b3b8c736_fk_init_material_Mnumber` FOREIGN KEY (`Mnumber_id`) REFERENCES `init_material` (`Mnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `init_material` (
  `Mnumber` varchar(10) NOT NULL,
  `Mname` varchar(10) NOT NULL,
  `Max_inventory` int NOT NULL,
  `Min_inventory` int NOT NULL,
  `Now_inventory` int NOT NULL,
  `Description` varchar(100) NOT NULL,
  `Picture` varchar(100) DEFAULT NULL,
  `Price` double NOT NULL,
  `Now_datetime` datetime DEFAULT CURRENT_TIMESTAMP,
  `Supplier` varchar(20) NOT NULL,
  PRIMARY KEY (`Mnumber`),
  UNIQUE KEY `init_material_Mname_bfbf7da8_uniq` (`Mname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `init_month` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `init_out_storage` (
  `Out_number` int NOT NULL AUTO_INCREMENT,
  `Out_way` varchar(8) NOT NULL,
  `Out_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `Out_supplier` varchar(20) NOT NULL,
  `Out_inventory` int NOT NULL,
  `Mnumber_id` varchar(10) NOT NULL,
  PRIMARY KEY (`Out_number`),
  KEY `init_out_storage_Mnumber_id_26826f3c_fk_init_material_Mnumber` (`Mnumber_id`),
  CONSTRAINT `init_out_storage_Mnumber_id_26826f3c_fk_init_material_Mnumber` FOREIGN KEY (`Mnumber_id`) REFERENCES `init_material` (`Mnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
BEGIN;
LOCK TABLES `inventory`.`auth_group` WRITE;
DELETE FROM `inventory`.`auth_group`;
INSERT INTO `inventory`.`auth_group` (`id`,`name`) VALUES (2, 'norml_group1'),(1, '普通');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`auth_group_permissions` WRITE;
DELETE FROM `inventory`.`auth_group_permissions`;
INSERT INTO `inventory`.`auth_group_permissions` (`id`,`group_id`,`permission_id`) VALUES (1, 1, 16),(2, 2, 37),(3, 2, 40),(4, 2, 41),(5, 2, 44),(6, 2, 45),(7, 2, 48);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`auth_permission` WRITE;
DELETE FROM `inventory`.`auth_permission`;
INSERT INTO `inventory`.`auth_permission` (`id`,`name`,`content_type_id`,`codename`) VALUES (1, 'Can add log entry', 1, 'add_logentry'),(2, 'Can change log entry', 1, 'change_logentry'),(3, 'Can delete log entry', 1, 'delete_logentry'),(4, 'Can view log entry', 1, 'view_logentry'),(5, 'Can add permission', 2, 'add_permission'),(6, 'Can change permission', 2, 'change_permission'),(7, 'Can delete permission', 2, 'delete_permission'),(8, 'Can view permission', 2, 'view_permission'),(9, 'Can add group', 3, 'add_group'),(10, 'Can change group', 3, 'change_group'),(11, 'Can delete group', 3, 'delete_group'),(12, 'Can view group', 3, 'view_group'),(13, 'Can add user', 4, 'add_user'),(14, 'Can change user', 4, 'change_user'),(15, 'Can delete user', 4, 'delete_user'),(16, 'Can view user', 4, 'view_user'),(17, 'Can add content type', 5, 'add_contenttype'),(18, 'Can change content type', 5, 'change_contenttype'),(19, 'Can delete content type', 5, 'delete_contenttype'),(20, 'Can view content type', 5, 'view_contenttype'),(21, 'Can add session', 6, 'add_session'),(22, 'Can change session', 6, 'change_session'),(23, 'Can delete session', 6, 'delete_session'),(24, 'Can view session', 6, 'view_session'),(25, 'Can add task', 7, 'add_task'),(26, 'Can change task', 7, 'change_task'),(27, 'Can delete task', 7, 'delete_task'),(28, 'Can view task', 7, 'view_task'),(29, 'Can add backup_form', 8, 'add_backup_form'),(30, 'Can change backup_form', 8, 'change_backup_form'),(31, 'Can delete backup_form', 8, 'delete_backup_form'),(32, 'Can view backup_form', 8, 'view_backup_form'),(33, 'Can add check_sheet', 9, 'add_check_sheet'),(34, 'Can change check_sheet', 9, 'change_check_sheet'),(35, 'Can delete check_sheet', 9, 'delete_check_sheet'),(36, 'Can view check_sheet', 9, 'view_check_sheet'),(37, 'Can add in_storage', 10, 'add_in_storage'),(38, 'Can change in_storage', 10, 'change_in_storage'),(39, 'Can delete in_storage', 10, 'delete_in_storage'),(40, 'Can view in_storage', 10, 'view_in_storage'),(41, 'Can add material', 11, 'add_material'),(42, 'Can change material', 11, 'change_material'),(43, 'Can delete material', 11, 'delete_material'),(44, 'Can view material', 11, 'view_material'),(45, 'Can add out_storage', 12, 'add_out_storage'),(46, 'Can change out_storage', 12, 'change_out_storage'),(47, 'Can delete out_storage', 12, 'delete_out_storage'),(48, 'Can view out_storage', 12, 'view_out_storage'),(49, 'Can add month', 13, 'add_month'),(50, 'Can change month', 13, 'change_month'),(51, 'Can delete month', 13, 'delete_month'),(52, 'Can view month', 13, 'view_month');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`auth_user` WRITE;
DELETE FROM `inventory`.`auth_user`;
INSERT INTO `inventory`.`auth_user` (`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) VALUES (1, 'pbkdf2_sha256$260000$FMyfy8sPUPIJvRpzDKMNge$gWuTXFcM3ekkpjNbPVtlRDpUR3XK2mbMT9lSxHFZTXM=', '2023-06-04 16:22:15.860000', 1, 'kj', '', '', '1623194916@qq.com', 1, 1, '2023-05-09 07:45:58.056000'),(13, 'pbkdf2_sha256$180000$EmS0OfSYTCTR$Qtn5v+YCfJX7u+G55ddZ3JjpqpW9FYZBnRzCjOKB5BI=', '2023-05-15 13:40:34.026000', 0, 'nor1', '', '', '', 1, 1, '2023-05-15 13:32:56.005000'),(14, 'pbkdf2_sha256$260000$5C7YFJrRRAoGSF8zHcJ6Hp$9WZL526jtWVvwtoSAmEK9HekJ0LMOplZYVRWAa9ATcc=', NULL, 1, 'kj2023', '', '', '', 1, 1, '2023-05-17 03:20:53.893000'),(21, 'pbkdf2_sha256$260000$e2v5hoWcZE8iSTisNPq6LW$2ApycmiLrFV75tE1YFOv3oYjdnkTR1kXqvwfUeZwTUw=', '2023-06-01 11:07:54.589000', 0, 'hwas12', '', '', '', 1, 1, '2023-06-01 10:50:50.268000'),(23, 'pbkdf2_sha256$260000$YjZIFvzYHIXVqf7CTLWYDy$dOthvy5aavXhOc3SgxOJLEv6N+Y4sea0A4/ljVlhlx4=', '2023-06-02 02:57:45.410000', 0, 'a1623194916', '', '', '', 1, 1, '2023-06-02 02:57:37.754000'),(24, 'pbkdf2_sha256$260000$TIDg1IFMpnYDMfxRNjhITt$wyXCNfFIh8avRdJwJS4yCJ5MFBGqo2WkIjlP8+H8Rgo=', '2023-06-02 03:01:51.128000', 0, 'a1623194916a', '', '', '', 1, 1, '2023-06-02 03:01:40.041000'),(25, 'pbkdf2_sha256$260000$0QZqfms3aLv07NsRsBjNoY$qvpceWlKFUgUPmwT9nhC2PI8zCEm+218LNrxoCarBtE=', '2023-06-04 16:18:13.951000', 0, 'a1623194916aa', '', '', '', 1, 1, '2023-06-04 16:18:04.896000'),(26, 'pbkdf2_sha256$260000$8nFYkmMZReZDzzj9UQy2zW$eUmbLicTpBwfgOEiUmHTl0ht0SUnl/+HJITbWnelZr4=', NULL, 0, 'a16231949166', '', '', '', 1, 1, '2023-06-04 16:20:45.583000'),(27, 'pbkdf2_sha256$260000$KQws7AZwMIyMiKtqIk0UvP$M0Z1x1TOXtg3wf62CogmnkgHapNqz0LvzOLSFDkgYw8=', '2023-06-04 16:21:41.969000', 0, 'a11623194916', '', '', '', 1, 1, '2023-06-04 16:21:26.623000');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`auth_user_groups` WRITE;
DELETE FROM `inventory`.`auth_user_groups`;
INSERT INTO `inventory`.`auth_user_groups` (`id`,`user_id`,`group_id`) VALUES (2, 21, 2),(4, 23, 2),(5, 24, 2),(6, 25, 2),(7, 26, 2),(8, 27, 2);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`auth_user_user_permissions` WRITE;
DELETE FROM `inventory`.`auth_user_user_permissions`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`django_admin_log` WRITE;
DELETE FROM `inventory`.`django_admin_log`;
INSERT INTO `inventory`.`django_admin_log` (`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) VALUES (1, '2023-05-10 11:22:04.659000', '1', 'test', 1, '[{\"added\": {}}]', 7, 1),(2, '2023-05-13 03:27:17.663000', '2', 'test', 1, '[{\"added\": {}}]', 4, 1),(3, '2023-05-13 03:27:54.978000', '3', 'test2', 1, '[{\"added\": {}}]', 4, 1),(4, '2023-05-13 03:30:14.554000', '4', 'test3', 1, '[{\"added\": {}}]', 4, 1),(5, '2023-05-13 03:34:40.576000', '5', 'test4', 1, '[{\"added\": {}}]', 4, 1),(6, '2023-05-13 03:35:07.391000', '6', 'a', 1, '[{\"added\": {}}]', 4, 1),(7, '2023-05-13 03:36:11.900000', '7', '13794020001', 1, '[{\"added\": {}}]', 4, 1),(8, '2023-05-13 05:04:09.345000', '8', 'aaaa', 1, '[{\"added\": {}}]', 4, 1),(9, '2023-05-15 12:33:33.085000', '9', 'nor1', 1, '[{\"added\": {}}]', 4, 1),(10, '2023-05-15 13:18:55.430000', '10', 'nor2', 1, '[{\"added\": {}}]', 4, 1),(11, '2023-05-15 13:19:12.184000', '11', 'nor3', 1, '[{\"added\": {}}]', 4, 1),(12, '2023-05-15 13:26:41.432000', '1', '普通', 1, '[{\"added\": {}}]', 3, 1),(13, '2023-05-15 13:29:23.490000', '12', 'nor4', 1, '[{\"added\": {}}]', 4, 1),(14, '2023-05-15 13:31:50.983000', '7', '13794020001', 3, '', 4, 1),(15, '2023-05-15 13:31:50.985000', '6', 'a', 3, '', 4, 1),(16, '2023-05-15 13:31:50.986000', '8', 'aaaa', 3, '', 4, 1),(17, '2023-05-15 13:31:50.987000', '9', 'nor1', 3, '', 4, 1),(18, '2023-05-15 13:31:50.988000', '10', 'nor2', 3, '', 4, 1),(19, '2023-05-15 13:31:50.989000', '11', 'nor3', 3, '', 4, 1),(20, '2023-05-15 13:31:50.990000', '12', 'nor4', 3, '', 4, 1),(21, '2023-05-15 13:31:50.991000', '2', 'test', 3, '', 4, 1),(22, '2023-05-15 13:31:50.992000', '3', 'test2', 3, '', 4, 1),(23, '2023-05-15 13:31:50.993000', '4', 'test3', 3, '', 4, 1),(24, '2023-05-15 13:31:50.994000', '5', 'test4', 3, '', 4, 1),(25, '2023-05-15 13:32:56.057000', '13', 'nor1', 1, '[{\"added\": {}}]', 4, 1),(26, '2023-05-17 03:20:53.976000', '14', 'kj2023', 1, '[{\"added\": {}}]', 4, 1),(27, '2023-05-29 11:15:48.624000', '1000001', '铁挂锁', 1, '[{\"added\": {}}]', 11, 1),(28, '2023-05-29 11:16:18.538000', '1000002', '长梁挂锁', 1, '[{\"added\": {}}]', 11, 1),(29, '2023-05-29 15:24:33.671000', '1000015', '不锈钢刀', 2, '[{\"changed\": {\"fields\": [\"\\u6700\\u5927\\u5e93\\u5b58\", \"\\u6700\\u5c0f\\u5e93\\u5b58\", \"\\u56fe\\u7247\"]}}]', 11, 1),(30, '2023-05-29 15:30:07.706000', '1000020', '油漆喷枪', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(31, '2023-05-29 15:33:53.502000', '1000020', '油漆喷枪', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(32, '2023-05-29 16:16:21.407000', '2', '2', 1, '[{\"added\": {}}]', 10, 1),(33, '2023-05-29 16:19:26.321000', '3', '3', 1, '[{\"added\": {}}]', 10, 1),(34, '2023-05-29 16:21:43.081000', '1000020', '油漆喷枪', 2, '[{\"changed\": {\"fields\": [\"\\u5f53\\u524d\\u5e93\\u5b58\"]}}]', 11, 1),(35, '2023-05-29 16:22:03.619000', '4', '4', 1, '[{\"added\": {}}]', 10, 1),(36, '2023-05-29 16:23:12.239000', '5', '5', 1, '[{\"added\": {}}]', 10, 1),(37, '2023-05-29 16:26:43.124000', '6', '6', 1, '[{\"added\": {}}]', 10, 1),(38, '2023-05-29 16:27:03.927000', '3', '3', 3, '', 10, 1),(39, '2023-05-29 16:27:03.928000', '2', '2', 3, '', 10, 1),(40, '2023-05-29 16:33:55.452000', '1000020', '油漆喷枪', 2, '[{\"changed\": {\"fields\": [\"\\u5f53\\u524d\\u5e93\\u5b58\"]}}]', 11, 1),(41, '2023-05-30 03:40:33.707000', '1000001', '铁挂锁', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(42, '2023-05-30 03:47:45.391000', '0', '0', 1, '[{\"added\": {}}]', 12, 1),(43, '2023-05-30 08:19:18.791000', '3', '3', 1, '[{\"added\": {}}]', 8, 1),(44, '2023-05-30 08:56:04.442000', '3', '3', 3, '', 8, 1),(45, '2023-05-30 10:06:59.085000', '10000020', '铁挂锁啊', 1, '[{\"added\": {}}]', 11, 1),(46, '2023-05-30 10:15:27.233000', '12', '铁挂锁a', 1, '[{\"added\": {}}]', 11, 1),(47, '2023-05-30 14:10:42.498000', '121', '铁挂锁a', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6599\\u5e8f\\u53f7\"]}}]', 11, 1),(48, '2023-05-30 14:14:41.001000', '1211', '铁挂锁a', 2, '[{\"changed\": {\"fields\": [\"\\u7269\\u6599\\u5e8f\\u53f7\"]}}]', 11, 1),(49, '2023-05-30 14:52:40.779000', '12213', '铁挂锁2', 1, '[{\"added\": {}}]', 11, 1),(50, '2023-05-30 14:53:37.278000', '12213', '铁挂锁2', 3, '', 11, 1),(51, '2023-05-30 14:55:00.534000', '12213', '铁挂锁2', 3, '', 11, 1),(52, '2023-05-30 14:57:35.631000', '1', '1', 3, '', 12, 1),(53, '2023-05-31 04:29:21.909000', '12213', '铁挂锁2', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(54, '2023-05-31 04:31:49.563000', '1000015', '不锈钢刀', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(55, '2023-05-31 04:34:03.761000', '1000019', '气焊割锯', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\", \"\\u5165\\u5e93\\u65f6\\u95f4\"]}}]', 11, 1),(56, '2023-05-31 04:35:07.235000', '1000018', '马钉枪', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\", \"\\u5165\\u5e93\\u65f6\\u95f4\"]}}]', 11, 1),(57, '2023-05-31 04:36:40.577000', '12213', '铁挂锁2', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(58, '2023-05-31 04:36:51.737000', '1000015', '不锈钢刀', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(59, '2023-05-31 04:38:44.402000', '1000015', '不锈钢刀', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(60, '2023-05-31 04:39:59.805000', '1000001', '铁挂锁', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(61, '2023-05-31 04:42:25.739000', '10000020', '铁挂锁啊', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(62, '2023-05-31 04:43:15.108000', '121', '铁挂锁a', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(63, '2023-05-31 04:46:36.699000', '1211', '铁挂锁a', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(64, '2023-05-31 04:46:48.047000', '12', '铁挂锁a', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(65, '2023-05-31 04:46:53.017000', '1000020', '油漆喷枪', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(66, '2023-05-31 05:03:07.015000', '12213', '铁挂锁2', 3, '', 11, 1),(67, '2023-05-31 05:03:07.017000', '1211', '铁挂锁a', 3, '', 11, 1),(68, '2023-05-31 05:03:07.018000', '121', '铁挂锁a', 3, '', 11, 1),(69, '2023-05-31 05:03:07.020000', '12', '铁挂锁a', 3, '', 11, 1),(70, '2023-05-31 05:03:23.310000', '10000020', '铁挂锁啊', 3, '', 11, 1),(71, '2023-05-31 08:42:47.241000', '1', '1', 1, '[{\"added\": {}}]', 9, 1),(72, '2023-05-31 15:40:48.868000', '2', '2', 1, '[{\"added\": {}}]', 12, 1),(73, '2023-05-31 16:01:37.923000', '1000020', '油漆喷枪', 3, '', 11, 1),(74, '2023-06-01 09:48:55.764000', '12', '铁挂锁2', 1, '[{\"added\": {}}]', 11, 1),(75, '2023-06-01 10:31:21.198000', '9', '9', 3, '', 8, 1),(76, '2023-06-01 10:32:05.664000', '1', '1', 3, '', 8, 1),(77, '2023-06-01 10:34:41.589000', '2', '2', 3, '', 8, 1),(78, '2023-06-01 10:35:36.806000', '3', '3', 3, '', 8, 1),(79, '2023-06-01 11:01:25.398000', '1000017', '镇流器', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\", \"\\u5165\\u5e93\\u65f6\\u95f4\"]}}]', 11, 1),(80, '2023-06-01 11:02:44.979000', '44', '44', 3, '', 8, 1),(81, '2023-06-01 11:02:44.986000', '43', '43', 3, '', 8, 1),(82, '2023-06-01 11:02:44.987000', '42', '42', 3, '', 8, 1),(83, '2023-06-01 11:02:44.988000', '41', '41', 3, '', 8, 1),(84, '2023-06-01 11:03:03.205000', '40', '40', 3, '', 8, 1),(85, '2023-06-01 11:03:03.206000', '39', '39', 3, '', 8, 1),(86, '2023-06-01 11:03:03.207000', '38', '38', 3, '', 8, 1),(87, '2023-06-01 11:03:03.208000', '37', '37', 3, '', 8, 1),(88, '2023-06-01 11:03:03.209000', '36', '36', 3, '', 8, 1),(89, '2023-06-01 11:03:03.210000', '35', '35', 3, '', 8, 1),(90, '2023-06-01 11:03:03.210000', '34', '34', 3, '', 8, 1),(91, '2023-06-01 11:03:03.211000', '33', '33', 3, '', 8, 1),(92, '2023-06-01 11:03:03.212000', '32', '32', 3, '', 8, 1),(93, '2023-06-01 11:03:03.213000', '31', '31', 3, '', 8, 1),(94, '2023-06-01 11:03:03.214000', '30', '30', 3, '', 8, 1),(95, '2023-06-01 11:03:03.215000', '29', '29', 3, '', 8, 1),(96, '2023-06-01 11:03:03.216000', '28', '28', 3, '', 8, 1),(97, '2023-06-01 11:03:03.216000', '27', '27', 3, '', 8, 1),(98, '2023-06-01 11:03:03.217000', '26', '26', 3, '', 8, 1),(99, '2023-06-01 11:03:03.218000', '25', '25', 3, '', 8, 1),(100, '2023-06-01 11:03:03.219000', '24', '24', 3, '', 8, 1),(101, '2023-06-01 11:03:03.220000', '23', '23', 3, '', 8, 1),(102, '2023-06-01 11:03:03.221000', '22', '22', 3, '', 8, 1),(103, '2023-06-01 11:03:03.222000', '21', '21', 3, '', 8, 1),(104, '2023-06-01 11:03:03.223000', '20', '20', 3, '', 8, 1),(105, '2023-06-01 11:03:03.224000', '19', '19', 3, '', 8, 1),(106, '2023-06-01 11:03:03.225000', '18', '18', 3, '', 8, 1),(107, '2023-06-01 11:03:03.226000', '17', '17', 3, '', 8, 1),(108, '2023-06-01 11:03:03.227000', '16', '16', 3, '', 8, 1),(109, '2023-06-01 11:03:03.228000', '15', '15', 3, '', 8, 1),(110, '2023-06-01 11:03:03.228000', '14', '14', 3, '', 8, 1),(111, '2023-06-01 11:03:03.229000', '13', '13', 3, '', 8, 1),(112, '2023-06-01 11:03:03.230000', '12', '12', 3, '', 8, 1),(113, '2023-06-01 11:03:03.231000', '11', '11', 3, '', 8, 1),(114, '2023-06-01 11:03:03.232000', '10', '10', 3, '', 8, 1),(115, '2023-06-01 11:03:03.232000', '8', '8', 3, '', 8, 1),(116, '2023-06-01 11:03:03.233000', '7', '7', 3, '', 8, 1),(117, '2023-06-01 11:03:03.234000', '6', '6', 3, '', 8, 1),(118, '2023-06-01 11:03:03.235000', '5', '5', 3, '', 8, 1),(119, '2023-06-01 11:03:03.236000', '4', '4', 3, '', 8, 1),(120, '2023-06-01 11:03:44.871000', '1000017', '镇流器', 3, '', 11, 1),(121, '2023-06-01 12:08:46.450000', '1000016', '电焊手套', 2, '[{\"changed\": {\"fields\": [\"\\u56fe\\u7247\"]}}]', 11, 1),(122, '2023-06-01 12:34:34.325000', '1', '1', 3, '', 8, 1),(123, '2023-06-02 02:59:05.504000', '12', '铁挂锁2', 3, '', 11, 1),(124, '2023-06-02 03:03:29.464000', '1', '铁挂锁2222', 1, '[{\"added\": {}}]', 11, 1),(125, '2023-06-02 03:06:01.368000', '7', '7', 1, '[{\"added\": {}}]', 10, 1),(126, '2023-06-02 03:07:39.519000', '1', '铁挂锁2222', 3, '', 11, 1),(127, '2023-06-02 03:07:39.530000', '1000001', '铁挂锁', 3, '', 11, 1),(128, '2023-06-04 16:23:52.734000', '123', '长梁挂锁23', 1, '[{\"added\": {}}]', 11, 1),(129, '2023-06-04 16:24:51.009000', '3', '3', 1, '[{\"added\": {}}]', 12, 1),(130, '2023-06-04 16:26:49.050937', '123', '长梁挂锁23', 3, '', 11, 1),(131, '2023-06-04 16:26:49.053048', '12', '铁挂锁2', 3, '', 11, 1);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`django_content_type` WRITE;
DELETE FROM `inventory`.`django_content_type`;
INSERT INTO `inventory`.`django_content_type` (`id`,`app_label`,`model`) VALUES (1, 'admin', 'logentry'),(3, 'auth', 'group'),(2, 'auth', 'permission'),(4, 'auth', 'user'),(5, 'contenttypes', 'contenttype'),(8, 'init', 'backup_form'),(9, 'init', 'check_sheet'),(10, 'init', 'in_storage'),(11, 'init', 'material'),(13, 'init', 'month'),(12, 'init', 'out_storage'),(7, 'init', 'task'),(6, 'sessions', 'session');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`django_migrations` WRITE;
DELETE FROM `inventory`.`django_migrations`;
INSERT INTO `inventory`.`django_migrations` (`id`,`app`,`name`,`applied`) VALUES (1, 'contenttypes', '0001_initial', '2023-05-09 07:45:42.677833'),(2, 'auth', '0001_initial', '2023-05-09 07:45:42.743847'),(3, 'admin', '0001_initial', '2023-05-09 07:45:42.894881'),(4, 'admin', '0002_logentry_remove_auto_add', '2023-05-09 07:45:42.932889'),(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-05-09 07:45:42.937956'),(6, 'contenttypes', '0002_remove_content_type_name', '2023-05-09 07:45:42.972899'),(7, 'auth', '0002_alter_permission_name_max_length', '2023-05-09 07:45:42.993907'),(8, 'auth', '0003_alter_user_email_max_length', '2023-05-09 07:45:43.008907'),(9, 'auth', '0004_alter_user_username_opts', '2023-05-09 07:45:43.013907'),(10, 'auth', '0005_alter_user_last_login_null', '2023-05-09 07:45:43.036913'),(11, 'auth', '0006_require_contenttypes_0002', '2023-05-09 07:45:43.037913'),(12, 'auth', '0007_alter_validators_add_error_messages', '2023-05-09 07:45:43.043914'),(13, 'auth', '0008_alter_user_username_max_length', '2023-05-09 07:45:43.070921'),(14, 'auth', '0009_alter_user_last_name_max_length', '2023-05-09 07:45:43.095926'),(15, 'auth', '0010_alter_group_name_max_length', '2023-05-09 07:45:43.108943'),(16, 'auth', '0011_update_proxy_permissions', '2023-05-09 07:45:43.113945'),(17, 'sessions', '0001_initial', '2023-05-09 07:45:43.123946'),(18, 'init', '0001_initial', '2023-05-10 11:05:31.261882'),(19, 'auth', '0012_alter_user_first_name_max_length', '2023-05-29 06:02:38.399058'),(20, 'init', '0002_auto_20230529_1849', '2023-05-29 10:49:16.452968'),(21, 'init', '0003_alter_material_picture', '2023-05-29 11:23:09.235493'),(22, 'init', '0004_alter_material_now_datetime', '2023-05-29 11:28:49.437794'),(23, 'init', '0005_auto_20230530_0015', '2023-05-29 16:15:39.954441'),(24, 'init', '0006_auto_20230530_1814', '2023-05-30 10:14:05.398489'),(25, 'init', '0007_auto_20230531_1314', '2023-05-31 05:14:48.371722'),(26, 'init', '0008_auto_20230531_1445', '2023-05-31 06:45:21.956792'),(27, 'init', '0009_auto_20230601_0046', '2023-05-31 16:46:18.187362'),(28, 'init', '0010_auto_20230601_0056', '2023-05-31 16:56:34.497632'),(29, 'init', '0011_alter_check_sheet_cnumber', '2023-06-01 10:11:55.261861');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`django_session` WRITE;
DELETE FROM `inventory`.`django_session`;
INSERT INTO `inventory`.`django_session` (`session_key`,`session_data`,`expire_date`) VALUES ('49xgplquob04dq3h8ru79g34gyyj2t01', '.eJyNVNFymzAQ_BUPz8ZGgATKY9_7BSXDSOgwqkF4EDT1ZPzv1UVOE4xN8nRCLMfu3kqvQSmmsSknC0OpVfAUkGD7eU-K6ggGX6jfwhz6XdWbcdByh5Dd9a3d_ewVtD-u2FmDRtjGfQ0gFIurpCJcpopXcZ7LRNQJ54oQ4BXlFXCWKlGnIBMqawDI45wLqiAHqLFpB2ayrtev1yIQp1MRPG2KQBs9FsHWrYzowO8VxZTFjLvCKMeS1kDwKWK1x2onw2NrEdq-1WrjFuMwVcewHpxED5uG1qP2QnXa7PFn-06MMGjR7j2mfAF9aEbERfgMWuGaRBG5bDefqaIpd6iyLE1c4YxGruRSpG-lIkuqFlmiraFtNLTKIzo03yIGnZnbQOMcfxEn2bLbe7MbrUhzj_tXgR-CksvzjWIyB8Re8YwCBY7yqKTIJJMCJ5GlEXsg7284iPOXwiipxXvz-33O2oRnF9mVSfbTWNqxH8QBFlrpzfAe5IwSRtd5vGijVjho85ACW9gdzwHpHbvnwc-YenM9kvwbwRd2LfdVA9WxtA3AuIx-MmeW3WHGsij3VqFjGaj_sVgyk4Nw1wpSO2njjhssmXXulDZLIumcSH4vkTLnfnRfJvLDIn_gwka0f2BtnnglTqey7oduSY7OyfHLc3D5B7D2sh0:1q5qUh:yjZ0PUbvLWbQnX0L97knlLoGULf0LMRKEUOpKZTdzm8', '2023-06-18 16:22:15.889000'),('7tem8lc8pz8bijni92fy9oip90h36de0', '.eJyNVNFymzAQ_BUPz8ZGgATKY9_7BSXDSOgwqkF4EDT1ZPzv1UVOE4xN8nRCLMfu3kqvQSmmsSknC0OpVfAUkGD7eU-K6ggGX6jfwhz6XdWbcdByh5Dd9a3d_ewVtD-u2FmDRtjGfQ0gFIurpCJcpopXcZ7LRNQJ54oQ4BXlFXCWKlGnIBMqawDI45wLqiAHqLFpB2ayrtev1yIQp1MRPG2KQBs9FsHWrYzowO8VxZTFjLvCKMeS1kDwKWK1x2onw2NrEdq-1WrjFuMwVcewHpxED5uG1qP2QnXa7PFn-06MMGjR7j2mfAF9aEbERfgMWuGaRBG5bDefqaIpd6iyLE1c4YxGruRSpG-lIkuqFlmiraFtNLTKIzo03yIGnZnbQOMcfxEn2bLbe7MbrUhzj_tXgR-CksvzjWIyB8Re8YwCBY7yqKTIJJMCJ5GlEXsg7284iPOXwiipxXvz-33O2oRnF9mVSfbTWNqxH8QBFlrpzfAe5IwSRtd5vGijVjho85ACW9gdzwHpHbvnwc-YenM9kvwbwRd2LfdVA9WxtA3AuIx-MmeW3WHGsij3VqFjGaj_sVgyk4Nw1wpSO2njjhssmXXulDZLIumcSH4vkTLnfnRfJvLDIn_gwka0f2BtnnglTqey7oduSY7OyfHLc3D5B7D2sh0:1q4zWm:CsB9ziFYdg9l7gSxNnMjtqTsBMpKmZ47fZCN_nc_Vag', '2023-06-16 07:48:52.630000'),('mk06614vnp51uaaavw8yj01dpv8wex0o', '.eJyNlNtymzAQhl_Fw7WxESAh5bL3fYKS8azQEtQA9nBo4sn43au1nMayad0rCfGz-v498BHtYJ6a3TzisLMmeopYtL4-01C9Yk8vzE_oX_abat9Pg9Ubkmwub8fN973B9ttFGwRoYGzc14hgRFplFVM6N6pKpdQZ1JlShjFUFVcVKpEbqHPUGdc1IspUKuAGJWJNQTvs59HF-vFRRnA4lNHTqoxsb6cyWrtdDx36s7Kci1QotwiuaMlrZPSUiNprrbPhtTXE4761ZuU20zBXr3E9OIteNg-tV23BdLbf0mXbDiYcLLRbr9m9oX1pJtIl9IzW0J4lCTutV9eolJQFVFHkmVuU4IlbpIb8vFTsHnUkSkprPDYWW-MVHSV_JA1lJkwDTyVdkWbFfbTPYDdeCXNL5xeDX4ay0_ONYxYKUu84QOCoyB7XnEgKDVSJIk_EX-y9xwMcHxrjrIbP4MtxjraPj65lb9zdeuJLyEzwfwd_s715EFjcJSsNBfnCzUpKX30hzmWDM0eew1LbNjAcVmH_Wme4xRjfqxZcn1qSL1BeQWUhVLEAFc5SIcy5kIlW_zFLMN6O0h1BHhLIBQJRJNIXhPJRoPnTUfcEegD3RyKEg-3dpOJjAh4SqKWW0FL5znjYxV858EMaN9D-wuV2uYIQAQRLTs_R6Tdd2rQQ:1q3bWb:xQ2Q_rDHnEO6fMNwZOhysPd3fizR3sV7tFCX5CIUnyk', '2023-06-12 11:58:57.544000'),('ptnvfn2vxrdfv0ub5hqjqwdojnneutvr', '.eJyNVMtyozAQ_BUXZ2ML0Isc975fsKQoCQ1Gax4uBJt1pfzvqwnOJhib5DRCNEN3T0uvQa7GocpHB31uTfAUxCzYft7UqjhCi2_Mb9Ueul3RtUNv9Q4hu-tbt_vZGah_XLGzBpVylf-amFJEaWkiSCLGqY5jMFoWXBpiZCENjaEEqRMpUhEnaRnJWCWEcEITaqiW2LSBdnS-16_XLFCnUxY8bbLAtnbIgq1ftaqBaS_LRhHz1BfOUiy0hAifCC8nrPUyJmypQtfV1mz8YujH4hiWvZc4wca-nlB7ZRrb7vFn-0YN0FtV7ydM_gL2UA2II_gM1uA6IiS6bDefqaIpd6hyQRNfUs6IL1Ir-laKaEnVIUu0NXSVhdpMiAbNd4hBZ-Y2sFjiL-JELLu9N7vRijT3uH8V-CEouTzfKI7mgHhSPKPAIEV5TDNkIrTCSQhK-AN5f8Nenb8UxqJSvTe_3-ds2_DsI7syyW4ccjd0vTrAQiu7Gd6DnLGIs3UeL7Y1Kxxs-5ACX9gdzwH0jt3z4Atu3lwnOv1G8JVby31RQXHMXQUwLKOfzJmJO8y4IHKyCh0TYP7HYslM98pfK0jtZFt_3GDJrPGntFoSoXMi8l4itUyn0X2ZyA-LpgMXVqr-A2vzxCtxPOVl1zdLcmxOLr08B5d_L4qwKA:1q5qTF:6cYDQ-wZPKOk52yXrhzB2HkaDwXGOFHTMmerKXMX3sw', '2023-06-18 16:20:45.727000'),('rrwu9rk9eic6yqq2g83gegu3j1fos9n8', '.eJyNVNFymzAQ_BUPz8ZGgATKY9_7BSXDSOgwqkF4EDT1ZPzv1UVOE4xN8nRCLMfu3kqvQSmmsSknC0OpVfAUkGD7eU-K6ggGX6jfwhz6XdWbcdByh5Dd9a3d_ewVtD-u2FmDRtjGfQ0gFIurpCJcpopXcZ7LRNQJ54oQ4BXlFXCWKlGnIBMqawDI45wLqiAHqLFpB2ayrtev1yIQp1MRPG2KQBs9FsHWrYzowO8VxZTFjLvCKMeS1kDwKWK1x2onw2NrEdq-1WrjFuMwVcewHpxED5uG1qP2QnXa7PFn-06MMGjR7j2mfAF9aEbERfgMWuGaRBG5bDefqaIpd6iyLE1c4YxGruRSpG-lIkuqFlmiraFtNLTKIzo03yIGnZnbQOMcfxEn2bLbe7MbrUhzj_tXgR-CksvzjWIyB8Re8YwCBY7yqKTIJJMCJ5GlEXsg7284iPOXwiipxXvz-33O2oRnF9mVSfbTWNqxH8QBFlrpzfAe5IwSRtd5vGijVjho85ACW9gdzwHpHbvnwc-YenM9kvwbwRd2LfdVA9WxtA3AuIx-MmeW3WHGsij3VqFjGaj_sVgyk4Nw1wpSO2njjhssmXXulDZLIumcSH4vkTLnfnRfJvLDIn_gwka0f2BtnnglTqey7oduSY7OyfHLc3D5B7D2sh0:1q4iXf:SsZmi9PrCwmcbNEfGVWdoBpOYSYzYMEPON-tZV043nw', '2023-06-15 13:40:39.403000'),('sbgj0lkw9lk9knoq6mj7zthljf4mlyni', '.eJyNVNFymzAQ_BUPz8ZGgATKY9_7BSXDSOgwqkF4EDT1ZPzv1UVOE4xN8nRCLMfu3kqvQSmmsSknC0OpVfAUkGD7eU-K6ggGX6jfwhz6XdWbcdByh5Dd9a3d_ewVtD-u2FmDRtjGfQ0gFIurpCJcpopXcZ7LRNQJ54oQ4BXlFXCWKlGnIBMqawDI45wLqiAHqLFpB2ayrtev1yIQp1MRPG2KQBs9FsHWrYzowO8VxZTFjLvCKMeS1kDwKWK1x2onw2NrEdq-1WrjFuMwVcewHpxED5uG1qP2QnXa7PFn-06MMGjR7j2mfAF9aEbERfgMWuGaRBG5bDefqaIpd6iyLE1c4YxGruRSpG-lIkuqFlmiraFtNLTKIzo03yIGnZnbQOMcfxEn2bLbe7MbrUhzj_tXgR-CksvzjWIyB8Re8YwCBY7yqKTIJJMCJ5GlEXsg7284iPOXwiipxXvz-33O2oRnF9mVSfbTWNqxH8QBFlrpzfAe5IwSRtd5vGijVjho85ACW9gdzwHpHbvnwc-YenM9kvwbwRd2LfdVA9WxtA3AuIx-MmeW3WHGsij3VqFjGaj_sVgyk4Nw1wpSO2njjhssmXXulDZLIumcSH4vkTLnfnRfJvLDIn_gwka0f2BtnnglTqey7oduSY7OyfHLc3D5B7D2sh0:1q4v3U:otiNdNkXTsICPaQqwFBlJEygAcdivyXQ8btH0J2DcP8', '2023-06-16 03:02:20.257000');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`init_backup_form` WRITE;
DELETE FROM `inventory`.`init_backup_form`;
INSERT INTO `inventory`.`init_backup_form` (`B_number`,`B_administrator`,`B_date`,`B_file`) VALUES (1, 'kj', '2023-06-01 12:35:14.407354', 'backup_20230601203514_kj_1.json'),(2, 'kj', '2023-06-01 12:36:17.918033', 'backup_20230601203617_kj_2.json'),(3, 'kj', '2023-06-01 14:43:49.971639', 'backup_20230601224349_kj_3.json'),(4, 'kj', '2023-06-02 02:58:48.153741', 'backup_20230602105847_kj_4.json'),(5, 'kj', '2023-06-02 03:07:25.098305', 'backup_20230602110724_kj_5.json'),(6, 'kj', '2023-06-04 16:26:37.731665', 'backup_20230605002637_kj_6.json');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`init_check_sheet` WRITE;
DELETE FROM `inventory`.`init_check_sheet`;
INSERT INTO `inventory`.`init_check_sheet` (`Cnumber`,`C_date`,`Now_inventory`,`Actual_num`,`Mnumber_id`) VALUES (1, '2023-06-01 10:12:08.126000', 4, 2, '12'),(2, '2023-06-01 10:12:55.682000', 4, 2, '12'),(3, '2023-06-01 10:13:13.590000', 2, 4, '12'),(4, '2023-06-02 03:06:38.248000', 4, 3, '1'),(5, '2023-06-04 16:25:48.123000', 2, 4, '123');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`init_in_storage` WRITE;
DELETE FROM `inventory`.`init_in_storage`;
INSERT INTO `inventory`.`init_in_storage` (`In_number`,`Source`,`In_date`,`In_supplier`,`In_inventory`,`Mnumber_id`) VALUES (4, '采购入库', '2023-05-29 16:22:04', '广东工业大学', 1, '1000020'),(5, '采购入库', '2023-05-29 16:23:12', '广东工业大学', 1, '1000020'),(6, '采购入库', '2023-05-29 16:26:43', '广东工业大学', 1, '1000020'),(7, '采购入库', '2023-06-02 03:06:01', '广东工业大学', 1, '1');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`init_material` WRITE;
DELETE FROM `inventory`.`init_material`;
INSERT INTO `inventory`.`init_material` (`Mnumber`,`Mname`,`Max_inventory`,`Min_inventory`,`Now_inventory`,`Description`,`Picture`,`Price`,`Now_datetime`,`Supplier`) VALUES ('1', '铁挂锁2222', 4, 1, 3, '三环365', 'C:/Users/Kj/Desktop/inventory/media/images/material_MxY4hWp.jpg', 44, '2023-06-02 03:02:00', '广东工业大学'),('1000001', '铁挂锁', 300, 100, 220, '三环366（63mm）', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 10, '2023-05-30 03:40:00', '锁厂'),('1000002', '长梁挂锁', 340, 100, 122, '三环365', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 12.6, '2023-04-30 03:40:00', '锁厂'),('1000003', '铜挂锁', 240, 100, 200, '三环265（50mm）', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 14.3, '2023-03-30 03:40:00', '锁厂'),('1000004', '汽车方向锁', 400, 100, 388, '棒球6089', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 50.8, '2023-02-28 03:40:00', '锁厂'),('1000005', '执手门锁', 500, 100, 302, 'hxA05（锡合金）', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 78.8, '2023-01-30 03:40:00', '锁厂'),('1000006', '灭火器', 300, 150, 230, 'ABC4KG', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 52.6, '2022-01-30 03:40:00', '消防工厂'),('1000007', '彩布条', 1000, 400, 600, '1*100米', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 136.4, '2021-01-30 03:40:00', '消防工厂'),('1000008', '电度表', 200, 50, 115, '三相DT862（30-100A）', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 94, '2020-01-30 03:40:00', '五金工厂'),('1000009', '梯子', 200, 50, 65, '铝合金折叠', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 145, '2020-06-30 03:40:00', '五金工厂'),('1000010', '樱花直排钉', 20000, 10000, 1290, '30#', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 9.8, '2020-01-25 03:40:00', '五金工厂'),('1000011', '镀锡铁丝', 30000, 12000, 25400, '14#', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 220, '2020-01-30 03:40:00', '五金工厂'),('1000012', '钢丝', 40000, 20000, 25000, '16#', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 110, '2020-01-30 03:40:00', '五金工厂'),('1000013', '电器插座', 1500, 900, 1200, '灰色八孔16A-027', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 20.5, '2020-06-30 03:40:00', '五金工厂'),('1000014', '九孔插座', 1500, 900, 1300, '16-A143', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 25, '2020-03-30 03:40:00', '五金工厂'),('1000015', '不锈钢刀', 400, 200, 399, '王刀7298', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 30, '2023-06-01 04:31:00', '五金工厂'),('1000016', '电焊手套', 1000, 300, 800, '牛皮带里', 'C:/Users/Kj/Desktop/inventory/media/images/bg1_76dXry3.jpg', 15, '2022-03-07 12:07:00', '装修工厂'),('1000017', '镇流器', 60, 20, 60, '吸顶灯32W', 'C:/Users/Kj/Desktop/inventory/media/images/bg5.jpg', 15, '2023-06-01 11:01:00', '装修工厂'),('1000018', '马钉枪', 800, 400, 760, '1013/422', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 160, '2020-05-16 22:00:00', '装修工厂'),('1000019', '气焊割锯', 700, 200, 700, 'D01-100', 'C:/Users/Kj/Desktop/inventory/media/images/material.jpg', 200, '2022-03-21 04:33:00', '装修工厂'),('1000020', '油漆喷枪', 700, 200, 699, 'PQ-1', 'C:/Users/Kj/Desktop/inventory/media/images/logo1_cIivF3s.png', 230, '2023-05-29 15:30:00', '装修工厂'),('12', '铁挂锁2', 5, 2, 4, '三环365', 'C:/Users/Kj/Desktop/inventory/media/images/bg1.jpg', 3, '2023-06-01 09:48:00', '随便'),('123', '长梁挂锁23', 4, 2, 4, 'inventory system using django', 'C:/Users/Kj/Desktop/inventory/media/images/material_SHnbMaj.jpg', 5, '2023-06-04 16:23:00', '广东工业大学');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`init_month` WRITE;
DELETE FROM `inventory`.`init_month`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `inventory`.`init_out_storage` WRITE;
DELETE FROM `inventory`.`init_out_storage`;
INSERT INTO `inventory`.`init_out_storage` (`Out_number`,`Out_way`,`Out_date`,`Out_supplier`,`Out_inventory`,`Mnumber_id`) VALUES (1, '消耗', '2023-05-30 03:47:45', '广东工业大学', 1, '1000020'),(2, '消耗', '2023-05-31 15:40:49', 'guanggong', 1, '1000015'),(3, '消耗', '2023-06-04 16:24:51', '广东工业大学', 2, '123');
UNLOCK TABLES;
COMMIT;
