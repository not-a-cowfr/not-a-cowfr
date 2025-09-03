{ config, inputs, ... }:
{
  services.nginx = {
    enable = true;

    virtualHosts."bot-backend.notacow.fr" = {
      addSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "awgielow@gmail.com";
  };

  systemd.services.nginx.serviceConfig.ReadWritePaths = [ "/var/log/nginx/" ];
}
