local _, ns = ...

-- Marcos de Blizzard que se pueden mover en WoW Forever, por categoria.
-- Sacados del codigo de interfaz de Forever (Gethe/wow-ui-source, rama
-- "forever"): los .toc de cada addon de Blizzard con el game type camelot.
-- Un nombre que no exista (o que aun no se haya cargado) se ignora sin errores;
-- los de carga bajo demanda se registran cuando su addon se carga.
ns.CATEGORIES = {
    {
        -- Ventanas: el Modo Edicion no las mueve. Se arrastran directamente.
        key = "WINDOWS",
        default = true,
        windows = true,
        list = {
            "CharacterFrame", "PlayerSpellsFrame", "ProfessionsFrame", "WorldMapFrame",
            "ContainerFrameCombinedBags", "ContainerFrame1", "ContainerFrame2", "ContainerFrame3",
            "ContainerFrame4", "ContainerFrame5", "ContainerFrame6",
            "BankFrame", "GuildBankFrame", "MerchantFrame", "MailFrame", "OpenMailFrame",
            "AuctionHouseFrame", "TradeFrame", "QuestFrame", "GossipFrame", "QuestLogPopupDetailFrame",
            "ClassTrainerFrame", "FriendsFrame", "CommunitiesFrame", "RaidParentFrame", "LFGParentFrame",
            "LFGBrowseFrame", "PVPUIFrame", "AchievementFrame", "CollectionsJournal", "EncounterJournal",
            "DressUpFrame", "TaxiFrame", "FlightMapFrame", "TabardFrame", "PetitionFrame",
            "GuildRegistrarFrame", "ItemTextFrame", "InspectFrame", "MacroFrame", "AddonList",
            "GameMenuFrame", "HelpFrame", "SettingsPanel", "CalendarFrame", "TimeManagerFrame",
            "StopwatchFrame", "ChatConfigFrame", "DeathRecapFrame", "ItemSocketingFrame",
            "ItemUpgradeFrame", "ItemInteractionFrame", "ArchaeologyFrame", "PetStableFrame",
            "TransmogFrame", "GuildControlUI", "ReadyCheckFrame", "ColorPickerFrame", "PlayerChoiceFrame",
        },
    },
    {
        -- Interfaz: elementos del HUD que el Modo Edicion tampoco mueve.
        key = "HUD",
        default = false,
        list = {
            "UIWidgetTopCenterContainerFrame", "UIWidgetBelowMinimapContainerFrame",
            "UIWidgetPowerBarContainerFrame", "PlayerPowerBarAlt", "UIErrorsFrame", "ZoneTextFrame",
            "SubZoneTextFrame", "ActionStatus", "AlertFrame", "GroupLootContainer", "BNToastFrame",
            "TicketStatusFrame", "ZoneAbilityFrame", "ExtraActionBarFrame", "TotemFrame", "ComboFrame",
            "GhostFrame", "EventToastManagerFrame", "BossBanner", "ObjectiveTrackerTopBannerFrame",
            "GameTimeFrame", "QueueStatusFrame", "PVPTimerFrame",
        },
    },
    {
        -- Modo Edicion: lo que ya mueve Blizzard, para ir mas alla (sin
        -- limites de rejilla). Desactivado por defecto: puede chocar con el
        -- propio Modo Edicion.
        key = "EDITMODE",
        default = false,
        list = {
            "MainActionBar", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarRight", "MultiBarLeft",
            "MultiBar5", "MultiBar6", "MultiBar7", "StanceBar", "PetActionBar", "PossessActionBar",
            "MultiCastActionBarFrame", "PlayerCastingBarFrame", "PlayerFrame", "TargetFrame", "FocusFrame",
            "PetFrame", "PartyFrame", "CompactRaidFrameContainer", "BossTargetFrameContainer",
            "MinimapCluster", "BuffFrame", "DebuffFrame", "ObjectiveTrackerFrame", "MicroMenuContainer",
            "BagsBar", "ChatFrame1", "EncounterBar", "ExtraAbilityContainer", "TalkingHeadFrame",
            "MainMenuBarVehicleLeaveButton", "LootFrame", "GameTooltipDefaultContainer",
            "MainStatusTrackingBarContainer", "SecondaryStatusTrackingBarContainer", "DurabilityFrame",
            "MirrorTimerContainer", "VehicleSeatIndicator", "ArcheologyDigsiteProgressBar",
            "EssentialCooldownViewer", "UtilityCooldownViewer", "BuffIconCooldownViewer",
            "BuffBarCooldownViewer", "PersonalResourceDisplayFrame", "RaidWarningFrame",
            "QueueStatusButton", "LossOfControlFrame", "SwingTimerMainHandFrame",
            "SwingTimerOffHandFrame", "SwingTimerRangedFrame", "DamageMeter",
        },
    },
}
