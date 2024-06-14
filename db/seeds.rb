# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seeds
  def initialize
    base_seeds!
    run_env_seeds!
  end

  private

  def run_env_seeds!
    seeder = "#{Rails.env}_seeds!"
    if respond_to?(seeder.to_sym, true)
      send(seeder)
    else
      log "Seeds for #{Rails.env} not defined, skipping.", level: :warn
    end
  end

  def base_seeds!
    # Set up user roles
    Role.create!(name: "admin", friendly_name: "Admin")
    Role.create!(name: "manager", friendly_name: "Manager")
    Role.create!(name: "analyst", friendly_name: "Analyst")

    # set up Actor Types ########################################################
    countries = Actortype.create!(
      title: "Country",
      is_active: true,
      is_target: true
    )

    orgs = Actortype.create!(
      title: "Organisation",
      is_active: true,
      is_target: false
    )

    classes = Actortype.create!(
      title: "Class",
      is_active: false,
      is_target: true,
      has_members: true
    )

    _regions = Actortype.create!(
      title: "Region",
      is_active: false,
      is_target: true,
      has_members: true
    )

    groups = Actortype.create!(
      title: "Group",
      is_active: true,
      is_target: false,
      has_members: true
    )

    # set up Activity Types ########################################################
    intl = Measuretype.create!(
      title: "International ",
      has_parent: true,
      has_target: false
    )

    regional_seas = Measuretype.create!(
      title: "Regional Seas Conventions ",
      has_parent: false,
      has_target: true
    )

    regional = Measuretype.create!(
      title: "Regional Strategies",
      has_parent: false,
      has_target: false
    )

    national = Measuretype.create!(
      title: "National Strategies",
      has_parent: false,
      has_target: false
    )

    _donations = Measuretype.create!(
      title: "Donor activities",
      has_parent: true,
      has_target: true
    )

    initiatives = Measuretype.create!(
      title: "Initiatives",
      has_parent: true,
      has_target: true
    )

    # set up Resource Types ########################################################
    _refs = Resourcetype.create!(
      title: "References"
    )
    _sites = Resourcetype.create!(
      title: "Websites"
    )
    _docs = Resourcetype.create!(
      title: "Documents"
    )
    _aps = Resourcetype.create!(
      title: "Action Plans"
    )
    _mlaps = Resourcetype.create!(
      title: "Marine Litter Action Plans"
    )

    # Set up taxonomies ########################################################
    # Convention status taxonomy - applies to int. and reg. seas conventions
    convstatus = Taxonomy.create!(
      title: "Convention status",
      allow_multiple: true
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: convstatus,
      measuretype: intl
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: convstatus,
      measuretype: regional_seas
    )
    # Admin. type taxonomy - applies to reg. seas conventions
    admintype = Taxonomy.create!(
      title: "Administration type",
      allow_multiple: true
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: admintype,
      measuretype: regional_seas
    )
    lbspstatus = Taxonomy.create!(
      title: "Status LBS-protocol",
      allow_multiple: false
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: lbspstatus,
      measuretype: regional_seas
    )
    # Strategy type taxonomy - applies to nat. and reg. strategies
    strategytype = Taxonomy.create!(
      title: "Strategy type",
      allow_multiple: true
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: strategytype,
      measuretype: regional
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: strategytype,
      measuretype: national
    )
    # Initiative type taxonomy - applies to initiatives
    initiativetype = Taxonomy.create!(
      title: "Initiative type",
      allow_multiple: true
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: initiativetype,
      measuretype: initiatives
    )

    # Group type taxonomy - applies to groups
    grouptype = Taxonomy.create!(
      title: "Type of group",
      allow_multiple: false
    )
    ActortypeTaxonomy.create!(
      taxonomy: grouptype,
      actortype: groups
    )

    # Org sector taxonomy - applies to orgs
    orgsector = Taxonomy.create!(
      title: "Sector",
      allow_multiple: false
    )
    ActortypeTaxonomy.create!(
      taxonomy: orgsector,
      actortype: orgs
    )

    # Org type taxonomy - applies to orgs, child of org sector
    # TODO: link parent
    orgtype = Taxonomy.create!(
      title: "Type of organisation",
      allow_multiple: false
    )
    ActortypeTaxonomy.create!(
      taxonomy: orgtype,
      actortype: orgs
    )
    # class type taxonomy - applies to classes
    classtype = Taxonomy.create!(
      title: "Type of country classification",
      allow_multiple: false
    )
    ActortypeTaxonomy.create!(
      taxonomy: classtype,
      actortype: classes
    )
    # country status taxonomy - applies to countries
    countrystatus = Taxonomy.create!(
      title: "Country status",
      allow_multiple: false
    )
    ActortypeTaxonomy.create!(
      taxonomy: countrystatus,
      actortype: countries
    )

    commlevel = Taxonomy.create!(
      title: "Commitment level",
      allow_multiple: false
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: commlevel,
      measuretype: intl
    )
    commtype = Taxonomy.create!(
      title: "Commitment type",
      allow_multiple: true
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: commtype,
      measuretype: intl
    )

    # Set up categories ########################################################
    # Convention status
    convstatus.categories.create!(title: "Signed")
    convstatus.categories.create!(title: "Adopted")
    convstatus.categories.create!(title: "In force")

    # Commitment level
    commlevel.categories.create!(title: "Legally binding")
    commlevel.categories.create!(title: "Non-legally binding")

    # Commitment type
    commtype.categories.create!(title: "Action Plan")
    commtype.categories.create!(title: "Action Programme")
    commtype.categories.create!(title: "Assembly")
    commtype.categories.create!(title: "Charter")
    commtype.categories.create!(title: "Conference")
    commtype.categories.create!(title: "Convention")
    commtype.categories.create!(title: "Declaration")
    commtype.categories.create!(title: "Expert Group")
    commtype.categories.create!(title: "Implementation Guidelines")
    commtype.categories.create!(title: "Informal Consultative Process")
    commtype.categories.create!(title: "Partnership")
    commtype.categories.create!(title: "Protocol")
    commtype.categories.create!(title: "Resolution")

    # LBS Prototcol status
    lbspstatus.categories.create!(title: "In place")
    lbspstatus.categories.create!(title: "Not yet entered into force")
    lbspstatus.categories.create!(title: "None")

    # Admin. type taxonomy
    admintype.categories.create!(
      title: "Established and administered independently",
      short_title: "Independent"
    )
    admintype.categories.create!(
      title: "Established under UN Environment, administered independently",
      short_title: "UN established"
    )
    admintype.categories.create!(
      title: "UN Environment-administered",
      short_title: "UN-administered"
    )
    # Strategy type taxonomy
    strategytype.categories.create!(
      title: "Plastic / marine litter strategy",
      short_title: "Plastic/ML"
    )
    strategytype.categories.create!(
      title: "Extendend Producer Responsibility policy",
      short_title: "EPR"
    )
    strategytype.categories.create!(
      title: "Strategy on microplastics",
      short_title: "Microplastics"
    )
    strategytype.categories.create!(
      title: "Strategy on single-use plastics",
      short_title: "Single-use"
    )
    strategytype.categories.create!(
      title: "No specific strategy",
      short_title: "Unspecific"
    )
    # Initiative type taxonomy
    # initiativetype.categories.create!(title: "Alliance")
    # initiativetype.categories.create!(title: "Association")
    # initiativetype.categories.create!(title: "Campaign")
    # initiativetype.categories.create!(title: "Coalition")
    # initiativetype.categories.create!(title: "Commitment")
    # initiativetype.categories.create!(title: "Community")
    # initiativetype.categories.create!(title: "Conference")
    # initiativetype.categories.create!(title: "Forum")
    # initiativetype.categories.create!(title: "High-level panel")
    # initiativetype.categories.create!(title: "Initiative")
    # initiativetype.categories.create!(title: "Knowledge centre")
    # initiativetype.categories.create!(title: "Movement")
    # initiativetype.categories.create!(title: "Multi-donor fund")
    # initiativetype.categories.create!(title: "Network")
    # initiativetype.categories.create!(title: "Other")
    # initiativetype.categories.create!(title: "Partnership")
    # initiativetype.categories.create!(title: "Platform")

    # Group type taxonomy
    grouptype.categories.create!(title: "Intergovernmental")
    grouptype.categories.create!(title: "Mixed")

    # Org sector taxonomy
    orgsector.categories.create!(title: "Civil society")
    orgsector.categories.create!(title: "Private sector")
    orgsector.categories.create!(title: "Science & research")
    orgsector.categories.create!(title: "Public sector")

    # Org type taxonomy
    # TODO: link with Science & R.
    orgtype.categories.create!(title: "Academia")
    # TODO: link with Science & R.
    orgtype.categories.create!(title: "Think tank")
    # TODO: link with Civil Society
    orgtype.categories.create!(title: "Foundation")
    # TODO: link with Civil Society
    orgtype.categories.create!(title: "Fund")
    # TODO: link with Civil S.
    orgtype.categories.create!(
      title: "Non-Governmental Organisation",
      short_title: "NGO"
    )
    # TODO: link with Civil S.
    orgtype.categories.create!(title: "Other civil society")
    # TODO: link with Private S.
    orgtype.categories.create!(title: "Consultancy")
    # TODO: link with Private S.
    orgtype.categories.create!(title: "Finance & investment")
    # TODO: link with Private S.
    orgtype.categories.create!(title: "Manufacturing & retail")
    # TODO: link with Private S.
    orgtype.categories.create!(title: "Recycling & disposal")
    # TODO: link with Private S.
    orgtype.categories.create!(title: "Social business")
    # TODO: link with Private S.
    orgtype.categories.create!(title: "Other private sector")

    # country class type taxonomy
    classtype.categories.create!(
      title: "Development (Natural Earth)",
      short_title: "Development"
    )
    classtype.categories.create!(
      title: "Income (World Bank)",
      short_title: "Income"
    )
    classtype.categories.create!(
      title: "Operational lending (World Bank)",
      short_title: "Lending"
    )
    classtype.categories.create!(
      title: "Official development assistance",
      short_title: "ODA"
    )

    # country status taxonomy
    countrystatus.categories.create!(title: "Country")
    countrystatus.categories.create!(title: "Dependency")
    countrystatus.categories.create!(title: "Disputed")
    countrystatus.categories.create!(title: "Indeterminate")
    countrystatus.categories.create!(title: "Sovereign country")
  end

  def development_seeds!
    nil unless User.count.zero?
  end

  def log(msg, level: :info)
    Rails.logger.public_send(level, msg)
  end
end

Seeds.new
