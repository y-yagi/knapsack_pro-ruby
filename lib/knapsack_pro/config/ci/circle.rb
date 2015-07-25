module KnapsackPro
  module Config
    module CI
      class Circle < Base
        def ci_node_total
          ENV['CIRCLE_NODE_TOTAL']
        end

        def ci_node_index
          ENV['CIRCLE_NODE_INDEX']
        end

        def commit_hash
          ENV['CIRCLE_SHA1']
        end

        def branch
          ENV['CIRCLE_BRANCH']
        end

        def project_dir
          project_repo_name = ENV['CIRCLE_PROJECT_REPONAME']
          "/home/ubuntu/#{project_repo_name}" if project_repo_name
        end
      end
    end
  end
end
