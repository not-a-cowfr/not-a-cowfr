{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  xdg.mimeApps = let
    associations = builtins.listToAttrs (map (name: {
        inherit name;
        value = let
          zen-browser = config.programs.zen-browser.package;
        in
          zen-browser.meta.desktopFileName;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };

  programs.zen-browser = {
    enable = true;

    policies = let
      mkLockedAttrs = builtins.mapAttrs (_: value: {
        Value = value;
        Status = "locked";
      });

      mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        installation_mode = "force_installed";
      });
    in {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = false;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true; # save webs for later reading
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = mkExtensionSettings {
        "uBlock0@raymondhill.net" = "ublock-origin";
        "{e7476172-097c-4b77-b56e-f56a894adca9}" = "minimaltwitter";
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = "refined-github-";
        "sponsorBlocker@ajay.app" = "sponsorblock";
        "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
      };
      Preferences = mkLockedAttrs {
		"accessibility.typeaheadfind.flashBar" = 0;
		"app.normandy.first_run" = false;

		"browser.aboutConfig.showWarning" = false;
		"browser.bookmarks.addedImportButton" = true;	
		"browser.bookmarks.restore_default_bookmarks" = false;	
		"browser.bookmarks.showMobileBookmarks" = false;	
		"browser.contentblocking.category" = "standard";	
		"browser.ctrlTab.sortByRecentlyUsed" = true;
		"browser.download.lastDir" = /home/andrew/Downloads;
		"browser.download.panel.shown" = true;
		"browser.download.viewableInternally.typeWasRegistered.avif" = true;
		"browser.download.viewableInternally.typeWasRegistered.jxl" = true;
		"browser.download.viewableInternally.typeWasRegistered.webp" = true;
		"browser.eme.ui.firstContentShown" = true;
		"browser.engagement.ctrlTab.has-used" = true;
		"browser.engagement.downloads-button.has-used" = true;
		"browser.formfill.enable" = true;
    	# Disable swipe gestures (Browser:BackOrBackDuplicate, Browser:ForwardOrForwardDuplicate)
        "browser.gesture.swipe.left" = "";
        "browser.gesture.swipe.right" = "";
		"browser.ml.enable" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
		"browser.preferences.experimental.hidden" = true;
        "browser.tabs.warnOnClose" = false;
        "browser.tabs.hoverPreview.enabled" = true;
		"browser.taskbar.previews.enable" = false;
        "browser.topsites.contile.enabled" = false;
		"browser.urlbar.suggest.engines" = false;	
		"browser.urlbar.suggest.openpage" = false;

		"devtools.everOpened" = true;
        "dom.battery.enabled" = false;

		"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        "gfx.webrender.all" = true;
        
		"media.videocontrols.picture-in-picture.video-toggle.enabled" = true;

        "network.cookie.cookieBehavior" = 5;
		"network.dns.disablePrefetch" = false;
        "network.http.http3.enabled" = true;

        "privacy.resistFingerprinting" = true;
        "privacy.firstparty.isolate" = true;

		"sidebar.old-sidebar.has-used" = true;	
		"sidebar.visibility" = "hide-sidebar";

		"zen.view.compact.enable-at-startup" = false;
		"zen.view.compact.hide-toolbar" = true;
		"zen.view.compact.should-enable-at-startup" = false;	
		"zen.view.show-newtab-button-top" = false;
		"zen.view.use-single-toolbar" = false;
		"zen.welcome-screen.seen" = true;
		"zen.workspaces.continue-where-left-off" = true;
      };
    };

    profiles.default = let
      containers = {
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 1;
        };
      };
    in {
      bookmarks = {
        force = true;
        settings = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
            #   {
            #     name = "homepage";
            #     url = "https://nixos.org/";
            #   }
            #   {
            #     name = "wiki";
            #     tags = ["wiki" "nix"];
            #     url = "https://wiki.nixos.org/";
            #   }
				{
					name = "Install vsix for extension";
					url = ''javascript:(function(){var extensionData={version:"",publisher:"",identifier:"",getDownloadUrl:function(){var p=this.identifier.split(".");return "https://"+p[0]+".gallery.vsassets.io/_apis/public/gallery/publisher/"+p[0]+"/extension/"+p[1]+"/"+this.version+"/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"},getFileName:function(){return this.identifier+"_"+this.version+".vsix"},getDownloadButton:function(){var b=document.createElement("a");b.innerHTML="Download VSIX";b.style.fontFamily="wf_segoe-ui,Helvetica Neue,Helvetica,Arial,Verdana";b.style.display="inline-block";b.style.padding="10px 20px";b.style.background="darkgreen";b.style.color="white";b.style.fontWeight="bold";b.style.fontSize="16px";b.style.margin="2px 5px";b.style.textDecoration="none";b.setAttribute("data-download-url",this.getDownloadUrl());b.setAttribute("data-download-filename",this.getFileName());b.onclick=function(e){var d=e.target.getAttribute("data-download-url"),f=e.target.getAttribute("data-download-filename"),a=document.createElement("a");a.href=d;a.download=f;a.click()};return b}};var metadataMap={"Version":"version","Publisher":"publisher","Unique Identifier":"identifier"};var rows=document.querySelectorAll(".ux-table-metadata tr");for(var i=0;i<rows.length;i++){var cells=rows[i].querySelectorAll("td");if(cells.length===2){var key=cells[0].innerText.trim(),value=cells[1].innerText.trim();if(metadataMap.hasOwnProperty(key))extensionData[metadataMap[key]]=value}};var mi=document.querySelector(".vscode-moreinformation");if(mi){mi.parentElement.appendChild(extensionData.getDownloadButton());}else{console.error("Element with class 'vscode-moreinformation' not found.");}var URL_VSIX_PATTERN='https://marketplace.visualstudio.com/_apis/public/gallery/publishers/''${publisher}/vsextensions/''${extension}/''${version}/vspackage';var itemName=new URL(window.location.href).searchParams.get("itemName");if(itemName){var parts=itemName.split("."),pub=parts[0],ext=parts[1],ver=document.querySelector("#versionHistoryTab%20tbody%20tr%20.version-history-container-column").textContent;var%20url=URL_VSIX_PATTERN.replace("''${publisher}",pub).replace("''${extension}",ext).replace("''${version}",ver);window.open(url,"_blank");}else{console.error("itemName%20parameter%20not%20found%20in%20URL");}})();'';
				}
            ];
          }
        ];
      };

      containersForce = true;
      inherit containers;

      spacesForce = true;
      spaces = {
        "coding" = {
          id = "f535e9e3-0959-45e8-8f1d-e8a4ca360451";
          icon = "💻";
          position = 1000;
        };
        "school" = {
          id = "d190dfb1-a69c-4534-8a18-f0c508798b27";
          icon = "🍎";
          container = containers."Work".id;
          position = 2000;
        };
      };

      search = {
        force = true;
        default = "google";
        engines = let
          nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        in {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nixSnowflakeIcon;
            definedAliases = ["np"];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = nixSnowflakeIcon;
            definedAliases = ["nop"];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "release";
                    value = "master";
                  }
                ];
              }
            ];
            icon = nixSnowflakeIcon;
            definedAliases = ["hmop"];
          };
          bing.metaData.hidden = "true";
        };
      };
    };
  };
}
