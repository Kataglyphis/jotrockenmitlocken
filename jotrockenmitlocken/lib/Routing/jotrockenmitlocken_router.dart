import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/about_me_page_navbar_config.dart';
import 'package:jotrockenmitlocken/Pages/Blog/ai_blog_config.dart';
import 'package:jotrockenmitlocken/Pages/Blog/ai_blog_page.dart';
import 'package:jotrockenmitlocken/Pages/Blog/rendering_blog_config.dart';
import 'package:jotrockenmitlocken/Pages/Blog/rendering_blog_page.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/document_page_navbar_config.dart';
import 'package:jotrockenmitlocken/Pages/DocumentsPage/documents_page.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/contact_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/cookie_declaration_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/declaration_on_accessibility_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/imprint_footer_config.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/configs/privacy_policy_config.dart';

import 'package:jotrockenmitlocken/Pages/Footer/Pages/contact.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/cookie_declaration.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/declaration_on_accessibility.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/imprint.dart';
import 'package:jotrockenmitlocken/Pages/Footer/Pages/privacy_policy.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page.dart';
import 'package:jotrockenmitlocken/Pages/LandingPage/landing_page_navbar_page_config.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_page.dart';
import 'package:jotrockenmitlocken/Pages/QuotesPage/quotes_pages_navbar_page_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Routing/router_creater.dart';

import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/stateful_branch_info_provider.dart';

class JotrockenMitLockenRoutes extends RoutesCreator {
  //final _footerKey = GlobalKey<NavigatorState>(debugLabel: "_footerKey");
  List<(Widget, StatefulBranchInfoProvider)> getAllPagesWithConfigs(
      AppAttributes appAttributes) {
    List<(Widget, StatefulBranchInfoProvider)> allPagesAndConfigs = [];
    allPagesAndConfigs += _getNavBarPagesAndConfigs(appAttributes);
    allPagesAndConfigs += _getFooterPagesAndConfigs(appAttributes);
    allPagesAndConfigs += _getBlogPagesAndConfigs(appAttributes);

    return allPagesAndConfigs;
  }

  List<(Widget, StatefulBranchInfoProvider)> _getNavBarPagesAndConfigs(
      AppAttributes appAttributes) {
    return [
      (
        LandingPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        LandingPageNavBarConfig()
      ),
      (
        AboutMePage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        AboutMePageNavBarConfig()
      ),
      (
        QuotesPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        QuotationsPageNavBarConfig()
      ),
      (
        DocumentPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        DocumentPageNavBarConfig()
      ),
    ];
  }

  List<(Widget, StatefulBranchInfoProvider)> _getBlogPagesAndConfigs(
      AppAttributes appAttributes) {
    return [
      (
        AiBlogPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        AiBlogPageConfig(),
      ),
      (
        RenderingBlogPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        RenderingBlogPageConfig(),
      ),
    ];
  }

  List<(Widget, StatefulBranchInfoProvider)> _getFooterPagesAndConfigs(
      AppAttributes appAttributes) {
    List<(Widget, StatefulBranchInfoProvider)> footerPages = [
      (
        ImprintPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        ImprintFooterConfig()
      ),
      (
        ContactPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        ContactFooterConfig()
      ),
      (
        PrivacyPolicyPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        PrivacyPolicyFooterConfig()
      ),
      (
        CookieDeclarationPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        CookieDeclarationFooterConfig()
      ),
      (
        DeclarationOnAccessibilityPage(
            footer: getFooter(appAttributes), appAttributes: appAttributes),
        DeclarationOnAccessibilityFooterConfig()
      ),
    ];
    return footerPages;
  }

  @override
  Footer getFooter(AppAttributes appAttributes) {
    return Footer(
      //key: _footerKey,
      footerPagesConfigs:
          appAttributes.screenConfigurations.getFooterPagesConfig(),
      userSettings: appAttributes.userSettings,
      footerConfig: appAttributes.footerConfig,
    );
  }
}
