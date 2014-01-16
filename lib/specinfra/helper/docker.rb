module SpecInfra
  module Helper
    module Docker
      def self.included(klass)
        begin
          require 'docker' unless defined?(::Docker)
        rescue LoadError
          fail "Docker client library is not available. Try installing `docker-api' gem."
        end

        if defined?(::RSpec)
          ::RSpec.configure {|c| c.include TransactionWrapper }
        end
      end

      module TransactionWrapper
        def self.included (g)
          g.around do |t|
            backend.transaction(&t)
          end
        end
      end
    end
  end
end
