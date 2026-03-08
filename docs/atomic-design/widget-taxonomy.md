# Atomic Design Widget Taxonomy

This file documents the atomic taxonomy adopted for the presentation layer and core widgets.

## Scope

- `lib/presentation`
- `lib/core/widgets`
- `lib/features/user_profile/presentation/pages`

## Layer Rules

- Atoms import only theme/foundation/utilities.
- Molecules import atoms and foundation, not templates/pages.
- Organisms import molecules/atoms, not pages.
- Templates compose organisms/molecules/atoms and layout slots.
- Pages own route/bloc orchestration and primarily compose templates/organisms.
- Pages may import atoms/molecules for local composition when a dedicated template/organism is unnecessary.
- Page-scoped steps under `presentation/pages/**/steps/**` are treated as template-level UI and must not orchestrate blocs/routes.
- Templates and organisms must not import `presentation/blocs/*`.
- Templates and organisms must receive route actions via callbacks (no direct `context.go/push/popOrGo`).
- Widgets must use `core/routing/navigation.dart` for route helpers (never `app_router.dart`).

## Input Standardization Notes

- `TextFormInputField`: canonical form input. Use `surface` for default cards and `subtle` for edit-flow backgrounds.
- `TextInputField`: canonical non-form text input with shared decoration variants.
- `SearchInputField`: canonical search field with built-in search icon and optional clear action.
- `NumericInputField`: canonical numeric form input (digits only) with parsed `int?` callback support.
- `DropdownFormInputField<T>`: canonical dropdown form input with same visual variants as text inputs.
- `SelectableInputCard`: canonical selectable option card (`check`, `radio`, `checkbox`, or `none`) with `row` and `stacked` layouts.
- `TimePickerField`: canonical reusable time selection input.
- `SelectableChip` remains canonical for chip-like filtering.
- `DatePickerField` remains canonical for tappable date selection.

## Inventory

- `lib/core/widgets/templates/app_scaffold.dart`: `AppScaffold` = Template, `_NavItem` = Molecule
- `lib/core/widgets/atoms/game_atoms.dart`: `GameRatingBadge` = Atom, `GamePriceLabel` = Atom
- `lib/core/widgets/molecules/review_widgets.dart`: `ReviewRatingBar` = Molecule, `ReviewCard` = Molecule
- `lib/presentation/widgets/atoms/auth/auth_error_text.dart`: `AuthErrorText` = Atom
- `lib/presentation/widgets/molecules/auth/auth_header.dart`: `AuthHeader` = Molecule
- `lib/presentation/widgets/atoms/auth/auth_submit_button.dart`: `AuthSubmitButton` = Atom
- `lib/presentation/widgets/atoms/common/app_bar_icon_action.dart`: `AppBarIconAction` = Atom
- `lib/presentation/widgets/atoms/common/button_loading_indicator.dart`: `ButtonLoadingIndicator` = Atom
- `lib/presentation/widgets/atoms/common/inline_feedback_text.dart`: `InlineFeedbackText` = Atom
- `lib/presentation/widgets/atoms/common/selectable_chip.dart`: `SelectableChip` = Atom (includes suggestion variant)
- `lib/presentation/widgets/atoms/common/media_placeholder.dart`: `MediaPlaceholder` = Atom
- `lib/presentation/widgets/atoms/common/surface_card.dart`: `SurfaceCard` = Atom
- `lib/presentation/widgets/molecules/auth/auth_switch_row.dart`: `AuthSwitchRow` = Molecule
- `lib/presentation/widgets/molecules/common/date_picker_field.dart`: `DatePickerField` = Molecule
- `lib/presentation/widgets/molecules/common/dropdown_form_input_field.dart`: `DropdownFormInputField<T>` = Molecule
- `lib/presentation/widgets/molecules/common/info_chip.dart`: `InfoChip` = Molecule
- `lib/presentation/widgets/molecules/common/label_value_row.dart`: `LabelValueRow` = Molecule
- `lib/presentation/widgets/molecules/common/media_upload_tile.dart`: `MediaUploadTile` = Molecule
- `lib/presentation/widgets/molecules/common/numeric_input_field.dart`: `NumericInputField` = Molecule
- `lib/presentation/widgets/molecules/common/page_app_bar.dart`: `PageAppBar` = Molecule
- `lib/presentation/widgets/molecules/common/removable_photo_tile.dart`: `RemovablePhotoTile` = Molecule
- `lib/presentation/widgets/molecules/common/search_input_field.dart`: `SearchInputField` = Molecule
- `lib/presentation/widgets/molecules/common/selectable_input_card.dart`: `SelectableInputCard` = Molecule
- `lib/presentation/widgets/molecules/common/section_header_block.dart`: `SectionHeaderBlock` = Molecule
- `lib/presentation/widgets/molecules/common/sliver_page_app_bar.dart`: `SliverPageAppBar` = Molecule
- `lib/presentation/widgets/molecules/common/text_form_input_field.dart`: `TextFormInputField` = Molecule
- `lib/presentation/widgets/molecules/common/text_input_field.dart`: `TextInputField` = Molecule
- `lib/presentation/widgets/molecules/common/time_picker_field.dart`: `TimePickerField` = Molecule
- `lib/presentation/widgets/organisms/catalog/available_today_section.dart`: `AvailableTodaySection` = Organism
- `lib/presentation/widgets/organisms/catalog/category_chips.dart`: `CategoryChips` = Organism, `_CategoryChip` = Molecule
- `lib/presentation/widgets/templates/catalog/discovery_view.dart`: `DiscoveryView` = Template
- `lib/presentation/widgets/organisms/catalog/empty_results_state.dart`: `EmptyResultsState` = Organism
- `lib/presentation/widgets/templates/catalog/filters_bottom_sheet.dart`: `FiltersBottomSheet` = Template, `_PriceInputField` = Molecule
- `lib/presentation/widgets/molecules/catalog/publication_card.dart`: `PublicationCard` = Molecule, `PublicationCardHorizontal` = Molecule
- `lib/presentation/widgets/organisms/catalog/publication_section.dart`: `PublicationSection` = Organism
- `lib/presentation/widgets/organisms/catalog/results_header.dart`: `ResultsHeader` = Organism
- `lib/presentation/widgets/templates/catalog/results_view.dart`: `ResultsView` = Template
- `lib/presentation/widgets/organisms/catalog/search_header.dart`: `SearchHeader` = Organism
- `lib/presentation/widgets/organisms/common/tabbed_page_app_bar.dart`: `TabbedPageAppBar` = Organism
- `lib/presentation/widgets/templates/catalog/search_sheet.dart`: `SearchSheet` = Template
- `lib/presentation/widgets/templates/common/bottom_sheet_shell.dart`: `BottomSheetShell` = Template
- `lib/presentation/widgets/templates/common/confirm_action_dialog.dart`: `ConfirmActionDialog` = Template helper
- `lib/presentation/widgets/templates/common/feedback_messenger.dart`: `FeedbackMessenger` = Template helper
- `lib/presentation/widgets/templates/common/wizard_scaffold.dart`: `WizardScaffold` = Template
- `lib/presentation/widgets/organisms/common/state_feedback_view.dart`: `StateFeedbackView` = Organism
- `lib/presentation/widgets/templates/common/success_state_view.dart`: `SuccessStateView` = Template
- `lib/presentation/widgets/templates/my_publications/edit_success_view.dart`: `EditSuccessView` = Template
- `lib/presentation/widgets/organisms/my_publications/my_publications_empty_view.dart`: `MyPublicationsEmptyView` = Organism
- `lib/presentation/widgets/organisms/my_publications/my_publications_error_view.dart`: `MyPublicationsErrorView` = Organism
- `lib/presentation/widgets/organisms/my_publications/my_publications_grid.dart`: `MyPublicationsGrid` = Organism
- `lib/presentation/widgets/organisms/my_publications/my_publications_loading_view.dart`: `MyPublicationsLoadingView` = Organism
- `lib/presentation/widgets/molecules/my_publications/rental_request_card.dart`: `RentalRequestCard` = Molecule
- `lib/presentation/widgets/templates/my_publications/rental_requests_view.dart`: `RentalRequestsView` = Template
- `lib/presentation/widgets/organisms/publication_details/availability_checker.dart`: `AvailabilityChecker` = Organism
- `lib/presentation/widgets/molecules/publication_details/game_recommendation_card.dart`: `GameRecommendationCard` = Molecule
- `lib/presentation/widgets/molecules/publication_details/game_review_card.dart`: `GameReviewCard` = Molecule
- `lib/presentation/widgets/molecules/publication_details/publication_detail_row.dart`: `GameDetailRow` = Molecule
- `lib/presentation/widgets/organisms/publication_details/publication_details_bottom_bar.dart`: `PublicationDetailsBottomBar` = Organism
- `lib/presentation/widgets/templates/publication_details/publication_details_error_view.dart`: `PublicationDetailsErrorView` = Template
- `lib/presentation/widgets/organisms/publication_details/publication_details_header.dart`: `PublicationDetailsHeader` = Organism
- `lib/presentation/widgets/organisms/publication_details/publication_details_info_header.dart`: `PublicationDetailsInfoHeader` = Organism
- `lib/presentation/widgets/templates/publication_details/publication_details_loading_view.dart`: `PublicationDetailsLoadingView` = Template
- `lib/presentation/widgets/templates/publication_details/publication_details_tab_content.dart`: `PublicationDetailsTabContent` = Template
- `lib/presentation/widgets/templates/publication_details/publication_reviews_tab_content.dart`: `PublicationReviewsTabContent` = Template
- `lib/presentation/widgets/molecules/publish/delivery_method_card.dart`: `DeliveryMethodCard` = Molecule
- `lib/presentation/widgets/templates/publish/delivery_method_sheet.dart`: `DeliveryMethodSheet` = Template
- `lib/presentation/widgets/organisms/publish/game_selector.dart`: `GameSelector` = Organism, `_SelectedGameCard` = Molecule
- `lib/presentation/widgets/templates/publish/publish_success_view.dart`: `PublishSuccessView` = Template
- `lib/presentation/widgets/molecules/publish/step_indicator.dart`: `StepIndicator` = Molecule
- `lib/presentation/widgets/organisms/rental/availability_date_selector.dart`: `AvailabilityDateSelector` = Organism
- `lib/presentation/pages/auth/login_page.dart`: `LoginPage` = Page
- `lib/presentation/pages/auth/register_page.dart`: `RegisterPage` = Page
- `lib/presentation/pages/catalog/home_page.dart`: `HomePage` = Page
- `lib/presentation/pages/my_publications/edit_publication_page.dart`: `EditPublicationPage` = Page, `_LoadingView` = Template, `_ErrorView` = Template
- `lib/presentation/pages/my_publications/my_publications_page.dart`: `MyPublicationsPage` = Page, `_PublicationsTab` = Template
- `lib/presentation/pages/my_publications/steps/edit_data_step.dart`: `EditDataStep` = Template, `_ConditionOption` = Molecule
- `lib/presentation/pages/my_publications/steps/edit_photos_step.dart`: `EditPhotosStep` = Template
- `lib/presentation/pages/my_publications/steps/edit_price_step.dart`: `EditPriceStep` = Template, `_DeliveryMethodTile` = Molecule
- `lib/presentation/pages/my_publications/steps/edit_review_step.dart`: `EditReviewStep` = Template
- `lib/presentation/pages/publication_details/game_reviews_page.dart`: `GameReviewsPage` = Page, uses `SelectableChip` atom
- `lib/presentation/pages/publication_details/game_rules_page.dart`: `GameRulesPage` = Page, `_CheatSheetSection` = Organism
- `lib/presentation/pages/publication_details/publication_details_page.dart`: `PublicationDetailsPage` = Page
- `lib/presentation/pages/publish/publish_game_page.dart`: `PublishGamePage` = Page
- `lib/presentation/pages/publish/steps/data_step.dart`: `DataStep` = Template
- `lib/presentation/pages/publish/steps/photos_step.dart`: `PhotosStep` = Template
- `lib/presentation/pages/publish/steps/price_step.dart`: `PriceStep` = Template
- `lib/presentation/pages/publish/steps/review_step.dart`: `ReviewStep` = Template
- `lib/presentation/pages/publish/steps/widgets/delivery_section.dart`: `DeliverySection` = Organism
- `lib/presentation/pages/publish/steps/widgets/price_section.dart`: `PriceSection` = Molecule
- `lib/presentation/pages/rental/rental_confirm_page.dart`: `RentalConfirmPage` = Page, `_PublicationSummary` = Organism, `_DeliverySelector` = Organism, `_FoodBundleSelector` = Organism, `_PaymentSelector` = Organism, `_PriceBreakdown` = Organism
- `lib/presentation/blocs/common/feedback_notice.dart`: `FeedbackNotice` + `FeedbackSeverity` = Presentation feedback types
- `lib/features/user_profile/presentation/pages/user_profile_page.dart`: `UserProfilePage` = Page, `_StatCard` = Molecule
