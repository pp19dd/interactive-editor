SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE IF NOT EXISTS `config` (
`id` int(10) unsigned NOT NULL,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `timeline_id` int(10) unsigned NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `meta` (
`id` int(10) unsigned NOT NULL,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `order_num` int(11) NOT NULL,
  `timeline_id` int(10) unsigned NOT NULL,
  `series` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('text','textarea','dropdown','checkbox','radio') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'text',
  `possible_values` text COLLATE utf8_unicode_ci NOT NULL,
  `default_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `slides` (
`id` int(10) unsigned NOT NULL,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `series` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pubdate` datetime NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `timelines` (
`id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_on` datetime NOT NULL,
  `status` enum('published','deleted') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'published',
  `new_renderer` enum('Yes','No') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Yes',
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent` int(10) unsigned DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `config`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `meta`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `slides`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `timelines`
 ADD PRIMARY KEY (`id`);


ALTER TABLE `config`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `meta`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
ALTER TABLE `slides`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `timelines`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
