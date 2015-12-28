SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
CREATE DATABASE IF NOT EXISTS `interactiveeditor` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `interactiveeditor`;

CREATE TABLE IF NOT EXISTS `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `timeline_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `order_num` int(11) NOT NULL,
  `timeline_id` int(10) unsigned NOT NULL,
  `series` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` enum('before','after','sidebar') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'sidebar',
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('text','textarea','dropdown','checkbox','radio') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `possible_values` text COLLATE utf8_unicode_ci NOT NULL,
  `default_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=77 ;

CREATE TABLE IF NOT EXISTS `slides` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `num_order` int(10) unsigned NOT NULL DEFAULT '0',
  `parent` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `series` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pubdate` datetime NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `timelines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_on` datetime NOT NULL,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `new_renderer` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Yes',
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=25 ;
