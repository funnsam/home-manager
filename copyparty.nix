{ config, pkgs, ... }:
{
    home.packages = with pkgs; [ copyparty ];

    systemd.user.services.copyparty = {
        Unit = {
            Description = "Copyparty sharing";
            After = [ "network.target" ];
        };
        Service = {
            Type = "simple";
            ExecStart = "${pkgs.copyparty}/bin/copyparty -c \"${./copyparty.conf}\"";
            Restart = "on-failure";
        };
        Install = {
            WantedBy = [ "default.target" ];
        };
    };
}
